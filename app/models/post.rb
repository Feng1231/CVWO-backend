class Post < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  validates :title, length: { in: 3..50 }, presence: true
  validates :body, length: { in: 8..5000 }, presence: true
  scope :pins, -> { where('is_pinned = true') }
  scope :not_pinned, -> { where('is_pinned = false') }

  def post_json
    new_post = attributes
    new_post['author'] = author.username
    new_post['category'] = category.name
    new_post
  end

  def self.author_posts_json(posts_array)
    returned_posts = []
    posts_array.each do |post|
      new_post = post.as_json(only: %i[id user_id is_pinned created_at])
      new_post['title'] = post.title.slice(0..30)
      new_post['body'] = post.body.slice(0..32)
      new_post['author'] = post.author.username
      new_post['category'] = post.category.name
      returned_posts.push(new_post)
    end

    returned_posts
  end

  def self.author_comments_json(comments_array)
    returned_comments = []
    comments_array.each do |comment|
      new_comment = comment.as_json
      new_comment['author'] = comment.author.username
      new_comment['server_date'] = DateTime.now
      returned_comments.push(new_comment)
    end

    returned_comments
  end

  def self.pins_json
    results = []
    all_pins = Post.pins
    all_pins.each do |p|
      new_post = p.post_json
      results.push(new_post)
    end

    results
  end
end
