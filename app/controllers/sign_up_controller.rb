# frozen_string_literal: true

class SignUpController < ApplicationController
    before_action :authorized_user?, only: %i[change_password destroy]

    # Register a new user account
    def create
        user = User.create!(sign_up_params)
        puts "User count: #{User.count}"
        user.update(admin_level: 1) if User.count <= 1

        json_response({ message: 'Account registered!' },
                    :created)
        url = 'localhost:3001/SignIn'
        redirect_to url
    end

    #change password
    def change_password
        if @current_user.try(:authenticate, params[:user][:oldPassword])
        if @current_user.update(password_params)
            json_response({ message: 'Password changed successfully' })
        else
            json_response({ errors: @current_user.errors.full_messages }, 400)
        end
        else
            json_response({ errors: 'Incorrect password' }, 401)
        end
    end

    def destroy
        user = User.find(params[:id])
        # Only allow the user to delete his own account
        unless user == @current_user
            return head(401)
        end

        user.destroy
        json_response({ message: 'Account deleted' })
    end

    private 
    
    def sign_up_params
    # whitelist params
    params.require(:user)
            .permit(:username, :password, :password_confirmation)
    end

    def password_params
    # whitelist params
    params.require(:user)
            .permit(:password, :password_confirmation)
    end
end
