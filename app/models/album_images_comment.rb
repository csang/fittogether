class AlbumImagesComment < ActiveRecord::Base

has_one :album_image
belongs_to :account

validates_presence_of :account_id, :album_image_id, :text
end
