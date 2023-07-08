class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:create]
  before_action :set_comments, only: [:index]

  def index
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_comments
    @post = Post.includes(:comments).find(params[:post_id])
    @comments = @post.comments
  end

  def comment_params
    params.require(:comment).permit(:author_id, :text)
  end
end
