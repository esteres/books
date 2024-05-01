module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        params.require(:username)
        params.require(:password)

        render json: { token: '123' }, status: :created
      end
    end
  end
end
