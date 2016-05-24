class CreateAccountCovers < ActiveRecord::Migration
  def change
    create_table :account_covers do |t|
      t.integer :account_id
      t.integer :position
      t.timestamps
    end
  end
end
