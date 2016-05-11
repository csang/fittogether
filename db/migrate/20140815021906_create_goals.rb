class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|

      t.string 'name', :limit => 250

      t.timestamps
    end
  end
end
