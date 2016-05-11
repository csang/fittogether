class AddShareWithToAlbum < ActiveRecord::Migration
  def change
	add_column :albums, :share_with, :string
  end
end
