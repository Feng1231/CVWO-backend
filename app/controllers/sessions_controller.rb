# frozen_string_literal: true

class SessionsController < ApplicationController
    before_action :authorized_user?, except: [:create, :retrieve]

    # When a user attempts to log in
    def create
        user = User.where(username: params[:user][:username].downcase).first
    
        return json_response({ errors: 'Incorrect credentials' }, 401) unless user
    
        authenticate_user(user)
    end
    

    # When a user logs out, remove authorization token
    def destroy
        @current_user.update_attribute(:token, nil)
        json_response(user: { logged_in: false })
    end
  
    # Checks if a user is still logged in
    def logged_in
        json_response(user: user_status(@current_user))
    end
    
    def retrieve
        token = request.headers['Authorization']
        @user = User.find_by(token: token)

        if @user 
            json_response(user: user_status(@user))
        else
            json_response({errors: 'User not found' }, 404)
        end
    end 
    private
  
    # Returns a Hash with additional keys for Front-End use
    def user_status(user)
        user_with_status = user.as_json(only: %i[id username token admin_level])
        user_with_status['logged_in'] = true
    
        user_with_status
    end
  
    # Returns user Hash after successful authentication
    def authenticate_user(user)
        if user.try(:authenticate, params[:user][:password])
            # generate authentication
            new_token = generate_token(user.id)
            if user.update_attribute(:token, new_token)
                json_response(user: user_status(user))
            else
                json_response({ errors: user.errors.full_messages }, 401)
            end
        else
            json_response({ errors: 'Incorrect credentials' }, 401)
        end
    end
end
