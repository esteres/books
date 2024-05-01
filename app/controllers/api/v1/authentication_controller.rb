module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user&.id)
        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by('username = ?', params.require(:username))
      end
    end
  end
end
