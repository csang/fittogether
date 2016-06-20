class CreateEventKudos < ActiveRecord::Migration
  def change
    create_table :event_kudos do |t|
      t.integer :event_id
      t.integer :account_id

      t.timestamps
    end
  end
end
