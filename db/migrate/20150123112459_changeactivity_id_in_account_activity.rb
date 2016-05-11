class ChangeactivityIdInAccountActivity < ActiveRecord::Migration
  def change
	change_column :account_activities, :activity_id, :string
  end
end
