class ApplicationController < ActionController::API
  class AuthenticationError < StandardError; end
  class BadRequestError < StandardError; end


  rescue_from BadRequestError, with: :handle_bad_request
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_bad_request
  rescue_from AuthenticationError, with: :handle_unauthenticated
  rescue_from ActiveRecord::RecordNotFound, with: :not_destroyed
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def authenticate_user
    token, _options = token_and_options(request)
    raise BadRequestError if token.nil?

    user_id = AuthenticationTokenService.decode(token)
    user = User.find_by('id = ?', user_id)

    raise AuthenticationError if user.nil?
  rescue JWT::DecodeError => error
    render json: { error: 'Invalid token' }, status: :unprocessable_entity
  end

  def not_found(error)
    render json: { errors: error.record.errros }, status: :unprocessable_entity
  end

  def parameter_missing(error)
    render json: {
      error: "param is missing or the value is empty: #{error.param}"
    }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    head :unauthorized
  end

  def handle_bad_request
    head :bad_request
  end
end
