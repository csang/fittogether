class AddSeenToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :seen, :integer, :default => 0
  end
end
