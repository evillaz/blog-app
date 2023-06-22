class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_posts_comments_counter
  after_destroy :update_posts_comments_counter

  def update_posts_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end