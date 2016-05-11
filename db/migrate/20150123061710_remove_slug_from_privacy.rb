class RemoveSlugFromPrivacy < ActiveRecord::Migration
  def change
    remove_column :privacies, :slug, :integer
  end
end
