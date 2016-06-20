class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :fitspot_id
      t.integer :account_id
      t.string :title
      t.text :description
      t.date :event_date
      t.string :event_start_time
      t.string :event_end_time
	  t.boolean :status, :default => true     

      t.timestamps
    end
  end
end
