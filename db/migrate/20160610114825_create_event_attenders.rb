class CreateEventAttenders < ActiveRecord::Migration
  def change
    create_table :event_attenders do |t|
      t.integer :event_id
      t.integer :account_id
      t.boolean :status, :default => true
      t.boolean :seen, :default => false

      t.timestamps
    end
  end
end
