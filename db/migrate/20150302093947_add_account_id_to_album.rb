class AddAccountIdToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :account_id, :integer
  end
end
