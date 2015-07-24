class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :account_id
      t.integer :trainer_id
      t.integer :score , :default => 0
   
      t.timestamps
    end
  end
end
