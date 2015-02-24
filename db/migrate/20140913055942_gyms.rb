class Gyms < ActiveRecord::Migration
  def change
  	   create_table :gyms do |t|

    	t.string 'name', :limit => 55
    	t.belongs_to :account_gym

      t.timestamps
    end
  end
end
