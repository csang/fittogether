class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.integer :event_id
      t.integer :account_id
      t.text :text
      t.boolean :status, :default => true
     
      t.timestamps
    end
  end
end
