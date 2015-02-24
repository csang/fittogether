class AddSlugToPrivacy < ActiveRecord::Migration
  def change
    add_column :privacies, :slug, :string
  end
end
