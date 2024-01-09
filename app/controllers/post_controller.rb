# frozen_string_literal: true

class PostController < ApplicationController
    before_action :authorized_user?, except: %i[show pin_post]
    before_action :authorized_admin?, only: %i[pin_post]
    before_action :set_post, only: %i[show update destroy pin_post]

    def show
        json_response({ post: @post.post_json,
                        comments: Post.author_comments_json(@post.comments) })
    end

    def create
        post = @current_user.posts.build(post_params)
        if post.save
            json_response(post: post.post_json)
        else
            json_response({ errors: post.errors.full_messages }, 401)
        end
    end

    def update
        # Only allow the owner to update post
        unless @post.author == @current_user
            return json_response({ errors: 'Account not Authorized' }, 401)
        end

        if @post.update(post_params)
            json_response(post: @post.post_json)
        else
            json_response({ errors: @post.errors.full_messages }, 401)
        end
    end

    def destroy
    # Only allow the owner or admin to destroy post
    unless @post.author == @current_user || @current_user.admin_level >= 1
        return json_response({ errors: 'Account not Authorized' }, 401)
    end

        @post.destroy
        json_response('Post destroyed')
    end
    
    def pin_post
        if @post.update(is_pinned: !@post.is_pinned)
            json_response(post: @post.post_json)
        else
            json_response({ errors: @post.errors.full_messages }, 401)
        end
    end
end
