class AddFieldsToAccountGoals < ActiveRecord::Migration
  def change
    add_column :account_goals, :for_id, :integer
    add_column :account_goals, :text, :text
    add_column :account_goals, :qty, :integer
    add_column :account_goals, :status, :integer
    add_column :account_goals, :valid_till, :datetime
  end
end
