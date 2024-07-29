class UsersFollowersController < ApplicationController
  def create
    @follow = current_user.users_followings.find_by(user_id: params[:user])
    if @follow.nil?
      flash.now[:notice] = "You already either follow the user or send a request to follow."
      follow = current_user.users_followings.build(user_id: params[:user], status: "pending")
      if follow.save
        redirect_to "/users/index"
      else
        flash[:notice] = "You already either follow the user or send a request to follow and now its pending."
        @users = User.all
        render "/users/index", status: :unprocessable_entity
      end
    else
      flash[:notice] = "You already either follow the user or send a request to follow and now its pending."
        @users = User.all
        render "/users/index", status: :unprocessable_entity
    end
  end
  def update
    @follow = current_user.users_followers.find_by(follower_id: params[:id])
    if @follow.update(status: params[:status]) then
      @follow.save
      redirect_to current_user
    else
      flash[:notice] = "You already are friends with the human."
      puts "Abraka dabra"
      render current_user, status: :unprocessable_entity
    end
  end
  private
end
