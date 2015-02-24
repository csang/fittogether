class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.integer :city_id
      t.string :name

      t.timestamps
    end
  end
end
