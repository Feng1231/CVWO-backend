# frozen_string_literal: true

class CategoryController < ApplicationController
    before_action :authorized_admin?, only: %i[create update destroy]
    before_action :set_category, only: %i[update destroy]
    before_action :set_page_params, only: %i[index show_by_category]
  
    # Shows all Category posts and appends their posts and by adding
    # new keys after converting to a hash
    def index
        all_categories = []
        category.all.each do |cateogry|
            new_category = category.attributes
            new_category['posts'] = category.posts(@per_page, @page) ##not sure of this line
            all_categories.push new_category
        end
  
        json_response(results: { categories: all_categories, pinned_posts: Post.pins_json,
                                per_page: @per_page, page: @page })
    end
  
    # Shows all category posts
    def index_all
        json_response(categorys: category.category_all_json)  
    end
  
    # Similar process to the index method but only shows one category record
    # along with its posts
    def show_by_category
        category = category.find_by(name: params[:category])
        selected_category = category.attributes
        selected_category['posts'] = category.posts(@per_page, @page) ##not very sure
    
        json_response(results: { category: selected_category,
                                per_page: @per_page, page: @page })
    end
  
    def update
      if @category.update(category_params)
        json_response(categories: category.category_all_json)
      else
        json_response({ errors: @category.errors.full_messages }, 401)
      end
    end
  
    def destroy
      @category.destroy
      json_response(categorys: category.category_all_json)
    end
  
    private
  
    def set_category
      @category = category.find(params[:id])
    end
  
    def set_page_params
      @per_page = params[:per_page].present? ? params[:per_page].to_i : 5
      @page = params[:page].present? ? params[:page].to_i : 1
    end
  
    def category_params
      params.require(:category)
            .permit(:name)
    end
end
