class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authored_posts, class_name: 'Post', foreign_key: 'author_id'
  
  accepts_nested_attributes_for :profile, :posts, :comments, allow_destroy: true
end
