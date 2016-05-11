class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.string 'name', :limit => 20

      t.timestamps
    end
  end
end
