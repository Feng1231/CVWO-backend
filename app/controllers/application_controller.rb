# frozen_string_literal: true

class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include TokenGenerator

    def authorized_user?
        json_response({ errors: 'Logged Out' }, 401) unless current_user
    end

    def authorized_admin?
        authorized_user?
        json_response({ errors: 'Insufficient Administrative Rights' }, 401) unless @current_user.admin_level.positive?
    end

    private

    # Sets a global @current_user variable if possible
    def current_user
      return nil unless access_token.present?
  
      @current_user ||= User.find_by(token: access_token)
      return nil unless @current_user
  
      @current_user
    end
    # Grabs the token placed in the HTTP Request Header, "Authorization"
    def access_token
      request.headers[:Authorization]
    end
end
