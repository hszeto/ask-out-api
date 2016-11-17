class ChangeFriendInUser < ActiveRecord::Migration
  def change
    remove_reference :events, :friend

    add_reference :events, :user, index: true
  end
end
