class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.integer :post_id
      t.integer :account_id

      t.timestamps
    end
  end
end
