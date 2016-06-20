class RenameReasonInToAccount < ActiveRecord::Migration
  def change
	
        change_column :accounts, :reason_id, :integer
  end
end
