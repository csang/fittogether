class AddConversationTypeToConversations < ActiveRecord::Migration
  def change
  add_column :conversations, :conversation_type, :integer, :default => 0
  end
end
