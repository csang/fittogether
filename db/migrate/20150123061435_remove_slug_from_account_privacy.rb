class RemoveSlugFromAccountPrivacy < ActiveRecord::Migration
  def change
    remove_column :account_privacies, :slug, :integer
  end
end
