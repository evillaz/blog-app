class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    like = Like.new
    like.author = current_user
    like.post = post
    if like.save
      flash[:success] = 'like saved successfully'
    else
      flash.now[:error] = 'Error: like could not be saved'
    end
    redirect_to request.referrer
  end
end
