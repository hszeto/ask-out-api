class FriendsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  def index
    @user = current_user
  end

  def add_friends
    all_user_except_current_user = User.all.select{ |u| u.email != current_user.email }

    @users = all_user_except_current_user.reject{ |u| current_user.friend_with?(u) }
  end

end