class AddColumnToChallenges < ActiveRecord::Migration
  def change
   add_column :challenges, :sender_status, :boolean, :default => true
   add_column :challenges, :recipient_status, :boolean, :default => true
  end
end
