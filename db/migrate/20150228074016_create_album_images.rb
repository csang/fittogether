class CreateAlbumImages < ActiveRecord::Migration
  def change
    create_table :album_images do |t|
      t.integer :album_id
      t.string :image

      t.timestamps
    end
  end
end
