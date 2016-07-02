class Event < ActiveRecord::Base

  belongs_to :account
  belongs_to :fitspot
  has_many :event_comment, :dependent =>:delete_all
  has_many :event_kudo, :dependent =>:delete_all
  has_many :event_attender, :dependent =>:delete_all
 
  #has_many :fitspot_member
  
  validates_presence_of :title
  #validates_presence_of :location
  validates_presence_of :event_date, :event_start_time, :event_end_time

   has_attached_file :image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :default_url => "group.jpg",
    :styles => { :medium => "730x250>", :thumb => "160x160>" }
 
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
  
 
 
end
