class CreateConversationMembers < ActiveRecord::Migration
  def change
    create_table :conversation_members do |t|
      t.integer :conversation_id
      t.integer :account_id

      t.timestamps
    end
  end
end
