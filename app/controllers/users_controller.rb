class UsersController < ApplicationController
  before_action -> { @user = User.find(params[:id])}, only: [:show]

  def show
    # @posts = @user.posts
  end

  def index
    @users = User.all
  end
end
