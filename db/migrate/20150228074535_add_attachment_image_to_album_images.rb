class AddAttachmentImageToAlbumImages < ActiveRecord::Migration
  def self.up
    change_table :album_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :album_images, :image
  end
end
