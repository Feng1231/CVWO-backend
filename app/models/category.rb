class Category < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates :name, length: { in: 3..20 }, presence: true,
                    uniqueness: { case_sensitive: false }
    before_save { name.downcase! }

    def category_posts
        retrieved_posts = posts

        Category.truncate_posts(retrieved_posts)
    end

    def self.truncate_posts(posts)
        returned_posts = []
        posts.each do |post|
            new_post = post.as_json(only: %i[id user_id is_pinned created_at updated_at])
            new_post['title'] = post.title.slice(0..30)
            new_post['body'] = post.body.slice(0..32)
            new_post['author'] = post.author.username
            new_post['category'] = post.category.name
            returned_posts.push(new_post)
        end
    
        returned_posts
    end

    def self.category_all_json
    returned_json = []
    Category.all.each do |category|
        new_category = category.as_json

        returned_json.push(new_category)
    end

    returned_json
    end
end
