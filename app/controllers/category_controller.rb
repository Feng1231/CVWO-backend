# frozen_string_literal: true

class CategoryController < ApplicationController
    before_action :authorized_admin?, only: %i[create update destroy]
    before_action :set_category, only: %i[update destroy]
  
    # Shows all Category posts and appends their posts and by adding
    # new keys after converting to a hash
    def index
        all_categories = []
        Category.all.each do |category|
            new_category = category.attributes
            new_category['posts'] = category.category_posts
            all_categories.push new_category
        end
        
        json_response(results: { categories: all_categories, pinned_posts: Post.pins_json })
    end
  
    # Shows all category posts
    def index_all
        json_response(categories: Category.category_all_json)  
    end
  
    # Similar process to the index method but only shows one category record
    # along with its posts
    def show_by_category
        category = Category.find_by(name: params[:category])
        selected_category = category.attributes
        selected_category['posts'] = category.posts
    
        json_response(results: { category: selected_category })
    end
  
    def create
      category = Category.create!(category_params)
      if category.save
        json_response(categories: Category.category_all_json)
      else 
        json_response({ errors: category.errors.full_messages }, 401)
      end
    end

    def update
      if @category.update(category_params)
        json_response(categories: Category.category_all_json)
      else
        json_response({ errors: @category.errors.full_messages }, 401)
      end
    end
  
    def destroy
      @category.destroy
    end
  
    private
  
    def set_category
      @category = Category.find(params[:id])
    end
  
    def category_params
      params.require(:category)
            .permit(:name)
    end
end
