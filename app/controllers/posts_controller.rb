class PostsController < ApplicationController
  before_action -> { @post = Post.find(params[:id]) }, only: [:show, :destroy, :update, :edit]

  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "New post created successfully"
      redirect_to @post
    else
      render new_post_path(@post), status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    if @post.destroy
      flash[:notice] = "Post destoyed succesfully."
      redirect_to posts_path
    else
      flash[:error] = "Post couldnt be destroyed."
      render posts_path
    end
  end
  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
