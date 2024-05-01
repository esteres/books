class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_destroyed
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def not_destroyed(error)
    render json: { errors: error.record.errros }, status: :unprocessable_entity
  end

  def parameter_missing(error)
    render json: {
      error: "param is missing or the value is empty: #{error.param}"
    }, status: :unprocessable_entity
  end
end
