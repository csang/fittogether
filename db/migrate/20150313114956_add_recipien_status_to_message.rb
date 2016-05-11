class AddRecipienStatusToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_status, :boolean, :default=>1
   
  end
end
