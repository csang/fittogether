class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string 'name', :limit => 20

      t.timestamps
    end
  end
end
