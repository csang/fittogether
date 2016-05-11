class RenameReasonInToAccount < ActiveRecord::Migration
  def change
	
        rename_column :accounts, :reason, :reason_id
        change_column :accounts, :reason_id, :integer
  end
end
