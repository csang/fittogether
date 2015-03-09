class Album < ActiveRecord::Base

 has_many :album_images, dependent: :destroy
  accepts_nested_attributes_for :album_images, :allow_destroy => true
end
