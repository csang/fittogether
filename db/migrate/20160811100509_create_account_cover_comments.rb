class CreateAccountCoverComments < ActiveRecord::Migration
  def change
    create_table :account_cover_comments do |t|
      t.integer :account_id
      t.integer :account_cover_id
      t.string :text

      t.timestamps
    end
  end
end
