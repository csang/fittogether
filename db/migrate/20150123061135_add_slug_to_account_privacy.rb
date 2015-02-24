class AddSlugToAccountPrivacy < ActiveRecord::Migration
  def change
    add_column :account_privacies, :slug, :integer
  end
end
