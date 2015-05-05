class CreateFitbits < ActiveRecord::Migration
  def change
    create_table :fitbits do |t|
      t.integer :steps
      t.integer :calories

      t.timestamps
    end
  end
end
