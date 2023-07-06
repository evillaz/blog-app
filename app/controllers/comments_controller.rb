class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post, comment: @comment } }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:new_comment).permit(:text))
    @comment.author = current_user
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post saved successfully'
          redirect_to user_post_url(@post.author, @post)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new
        end
      end
    end
  end

  def destroy 
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer
  end
end
