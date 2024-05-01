module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user&.id)
        params.require(:password)

        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by('username = ?', params.require(:username))
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
