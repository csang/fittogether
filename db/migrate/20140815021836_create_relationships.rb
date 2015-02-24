class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|

      t.string 'name', :limit => 20

      t.timestamps
    end
  end
end
