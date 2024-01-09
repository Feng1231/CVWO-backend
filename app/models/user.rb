class User < ApplicationRecord
    has_secure_password
    has_many :posts, inverse_of: 'author', dependent: :destroy #deletes comments and posts as well
    has_many :comments, dependent: :destroy
    validates :username, length: { in: 4..32 }, presence: true, #username 4-32, also must be present
                         uniqueness: { case_sensitive: false } #username must be unique
    validates :password, length: { minimum: 8 } #minimum of 8 character
    validates :admin_level, numericality: { only_integer: true,
                                            less_than_or_equal_to: 1 }
    before_save { username.downcase! }
end
