class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_users_posts_counter
  after_destroy :update_users_posts_counter

  def recent_comments
    comments.last(5)
  end

  def update_users_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
