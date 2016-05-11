class AddMessageTypeToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :message_type, :integer, :default => 0
  end
end
