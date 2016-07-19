class AddRequestIdToGroupMember < ActiveRecord::Migration
  def change
    add_column :group_members, :inviter_id, :integer
  end
end
