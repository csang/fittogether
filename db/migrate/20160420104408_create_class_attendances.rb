class CreateClassAttendances < ActiveRecord::Migration
  def change
    create_table :class_attendances do |t|
      t.integer :account_id
      t.integer :gym_class_id
      t.boolean :status

      t.timestamps
    end
  end
end
