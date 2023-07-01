class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = post.likes.new
    like.author = current_user
    respond_to do |format|
      format.html do
        if like.save
          flash[:success] = 'like saved successfully'
          redirect_to user_post_url(post.author, post)
        else
          flash.now[:error] = 'Error: like could not be saved'
        end
      end
    end
  end
end
