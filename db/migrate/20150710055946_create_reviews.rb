class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :gym_id
      t.integer :account_id

      t.timestamps
    end
  end
end
