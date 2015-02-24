class CreateAccountActivities < ActiveRecord::Migration
  def change
    create_table :account_activities do |t|

      t.integer 'account_id'
      t.integer 'activity_id'
      
      t.timestamps
    end
    add_index('account_activities', :account_id)
    add_index('account_activities', :activity_id)
  end
end
