class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|

      t.string 'name', :limit => 20

      t.timestamps
    end
  end
end
