class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to friends_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Friend removed from your list."
    redirect_to friends_path
  end
end