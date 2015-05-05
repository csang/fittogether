class Album < ActiveRecord::Base

 has_many :album_images, :dependent =>:delete_all
 
 validates_presence_of :title
  accepts_nested_attributes_for :album_images, :allow_destroy => true
 
  belongs_to :account
end
