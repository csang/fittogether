class Group < ActiveRecord::Base
  serialize :activity_ids, Array
  belongs_to :account
  has_many :group_member, :dependent =>:delete_all
  has_many :group_cover, :dependent =>:delete_all
  has_many :post, :dependent =>:delete_all
  # has_many :fitspot
  
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :address
  validates_presence_of :account_id
  
  has_attached_file :group_image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :default_url => "group.jpg",
    :styles => {:medium => "730x250#",  :thumb => "160x160>" }
 
  validates_attachment_content_type :group_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
 
  accepts_nested_attributes_for :group_member, :allow_destroy => true
end
