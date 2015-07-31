class Fitspot < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :group
  has_many :fitspot_member
  
validates_presence_of :title
validates_presence_of :location
validates_presence_of :fitspot_date

   has_attached_file :fitspot_image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :default_url => "group.jpg",
    :styles => { :medium => "730x250>", :thumb => "160x160>" }
 
  validates_attachment_content_type :fitspot_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
 

end