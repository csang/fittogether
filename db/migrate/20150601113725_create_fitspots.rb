class CreateFitspots < ActiveRecord::Migration
  def change
    create_table :fitspots do |t|
      t.integer :group_id
      t.integer :account_id
      t.string :title
      t.text :description
      t.string :fitspot_image
      t.string :location
      t.date :fitspot_date
      t.string :fitspot_time
      t.boolean :status, :default => true     
      t.timestamps
    end
  end
end
