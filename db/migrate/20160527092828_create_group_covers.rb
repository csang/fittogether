class CreateGroupCovers < ActiveRecord::Migration
  def change
    create_table :group_covers do |t|
      t.integer :group_id
      t.integer :position
      t.string :position_offset

      t.timestamps
    end
  end
end
