class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|

    	t.string 'name', :limit => 55

      t.timestamps
    end
  end
end
