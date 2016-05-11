class AddSeenToGroupMember < ActiveRecord::Migration
  def change
    add_column :group_members, :seen, :boolean, :default => false
  end
end
