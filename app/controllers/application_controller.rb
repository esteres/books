class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_destroyed

  private

  def not_destroyed(error)
    render json: { errors: erro.record.errros }, status: :unprocessable_entity
  end
end
