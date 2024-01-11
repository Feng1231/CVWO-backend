# frozen_string_literal: true

class UsersController < ApplicationController
    before_action :set_user, only: %i[show]

    def index
      all_users = User.all.order(created_at: :desc)
      users_array = []
      all_users.each do |user|
        new_user = user.as_json(only: %i[id username admin_level])

        users_array.push(new_user)
      end
  
      json_response(users: users_array)
    end
  
    def show
      json_response(user: user_info(@user))
    end
    
    private
  
    def set_user
      @user = User.find_by(params[:id])
    end
    
    # Returns a hash object of a user
    def user_info(user)
      user_with_attachment = user.as_json(only: %i[id username admin_level])
      user_with_attachment['posts'] = Post.author_posts_json(user.posts)
      user_with_attachment['comments'] = Comment.author_comments_json(user.comments.last(3))
      user_with_attachment['server_date'] = DateTime.now
    
      user_with_attachment
    end
  end