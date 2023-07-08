class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.includes(:comments)

    render json: @posts
  end

  def show
    render json: @post
  end

  private

  def set_post
    @post = Post.includes(:comments).find(params[:id])
  end
end
