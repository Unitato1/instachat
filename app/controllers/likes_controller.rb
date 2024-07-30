class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    if @like.save
      flash[:notice] = "You liked the post."
    else
      flash[:notice] = "You alredy liked the post."
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:id])
    if !@like.nil? && @like.destroy
      flash[:notice] = "You unliked the post."

    else
      flash[:notice] = "You alredy unliked the post."
    end
    redirect_back(fallback_location: root_path)
  end

  def update
  end
end
