class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :category, index: true
      t.references :account, index: true
      t.integer :to_id
      t.string :text
      t.integer :accept_status, :default => 0
      t.integer :reward_points
      t.string :status, :default => 'new'

      t.timestamps
    end
  end
end
