class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :account_id
      t.integer :friend_id
      t.boolean :approved

      t.timestamps
    end
  end
end
