class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|

    	t.string 'name', :limit => 55

      t.timestamps
    end
  end
end
