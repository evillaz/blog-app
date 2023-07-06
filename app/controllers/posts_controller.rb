class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.includes(comments: :author).order(created_at: :asc).paginate(page: params[:page], per_page: 3)
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post, user: @user } }
    end
  end

  def create
    @user = current_user
    @post = @user.posts.new(params.require(:new_post).permit(:title, :text))
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post saved successfully'
          redirect_to user_posts_url(@user)
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new
        end
      end
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    if @post.comments.present?
      @post.comments.destroy_all
    end
    if @post.likes.present?
      @post.likes.destroy_all
    end
    @post.destroy
    redirect_to user_posts_path(user_id: @post.author_id)
  end
end
