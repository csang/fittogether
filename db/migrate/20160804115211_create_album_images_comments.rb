class CreateAlbumImagesComments < ActiveRecord::Migration
  def change
    create_table :album_images_comments do |t|
      t.integer :album_image_id
      t.integer :account_id
      t.string :text

      t.timestamps
    end
  end
end
