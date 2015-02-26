class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
