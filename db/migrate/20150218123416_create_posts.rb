class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :account_id
      t.text :text
      t.string :share_with
      t.integer :status

      t.timestamps
    end
  end
end
