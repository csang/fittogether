class AddSlugToMigration < ActiveRecord::Migration
  def change
    add_column :activities, :slug, :string
  end
end
