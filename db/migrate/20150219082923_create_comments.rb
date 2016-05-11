class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_it
      t.integer :account_id
      t.text :text
      t.integer :status

      t.timestamps
    end
  end
end
