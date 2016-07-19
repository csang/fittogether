class Fitspot < ActiveRecord::Base
   serialize :activity_ids, Array
  geocoded_by :location
  belongs_to :account
  has_many :fitspot_member, :dependent =>:delete_all
  has_many :fitspot_cover, :dependent =>:delete_all
  has_many :event, :dependent =>:delete_all
       
  
  validates_presence_of :title
  validates_presence_of :location
  #validates_presence_of :fitspot_date
  after_validation :geocode, :if => :location_changed?
   has_attached_file :fitspot_image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :default_url => "group.jpg",
    :styles => { :medium => "730x250>", :thumb => "160x160>" }
 
  validates_attachment_content_type :fitspot_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
 

end
