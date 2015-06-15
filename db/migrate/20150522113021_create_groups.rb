class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.integer :account_id
      t.boolean :status, :default => true
      t.boolean :is_public,:default => true

      t.timestamps
    end
  end
end
