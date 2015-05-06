class AddIsReadToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :is_read, :boolean, :default =>false
   
  end
end
