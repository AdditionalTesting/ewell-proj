class AddFriendCountForMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :friend_count, :integer, default: 0
  end
end
