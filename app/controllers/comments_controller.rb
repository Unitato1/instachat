class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Added the comment."
    else
      flash[:notice] = "Sorry but comment couldnt be added, try again."
    end
    redirect_back(fallback_location: root_path)
  end
  def edit
    @post_id = params[:post_id]
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Edited the comment."
    else
      flash[:notice] = "Sorry but comment couldnt be edited, try again."
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Deleted the comment."
    else
      flash[:notice] = "Sorry but comment couldnt be deleted, try again."
    end
    redirect_back(fallback_location: root_path)
  end
  def comment_params
    result = params.require(:comment).permit(:post_id, :content)
    result[:author_id] = current_user.id
    result
  end
end
