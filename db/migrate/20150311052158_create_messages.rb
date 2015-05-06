class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :is_read, :default => true
      t.boolean :status,:default => true
      t.references :conversation, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
