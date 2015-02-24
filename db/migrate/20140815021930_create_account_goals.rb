class CreateAccountGoals < ActiveRecord::Migration
  def change
    create_table :account_goals do |t|

      t.integer 'account_id'
      t.integer 'goal_id'

      t.timestamps
    end
    add_index('account_goals', :account_id)
    add_index('account_goals', :goal_id)
  end
end
