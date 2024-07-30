class UsersFollowersController < ApplicationController
  def create
    @follow = current_user.users_followings.find_by(user_id: params[:user])
    if @follow.nil?
      follow = current_user.users_followings.build(user_id: params[:user], status: "pending")
      if follow.save
        flash[:notice] = "Follow send wait for #{User.find(id: params[:user]).username} to accept it "
        redirect_to "/users/index"
      else
        flash.now[:notice] = "There was problem adding follow try again."
        @users = User.all
        render "/users/index", status: :unprocessable_entity
      end
    else
        flash.now[:notice] = "You already either follow the user or send a request to follow and now its pending."
        @users = User.all
        render "/users/index", status: :unprocessable_entity
    end
  end
  def update
    @follow = current_user.users_followers.find_by(follower_id: params[:id])
    if @follow.update(status: params[:status]) then
      @follow.save
      flash[:notice] = "#{User.find(id: params[:user]).username} is your friend now."
      redirect_to current_user
    else
      flash.now[:notice] = "Something went wrong please try again."
      render current_user, status: :unprocessable_entity
    end
  end
  private
end
