class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :account_id
      t.boolean :status, :default => true
     
      t.timestamps
    end
  end
end
