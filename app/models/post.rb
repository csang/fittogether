class Post < ActiveRecord::Base

belongs_to :account
has_many :comment,  :dependent =>:delete_all


has_attached_file :image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :styles => { :medium => "300x300>", :thumb => "160x160>" }
    
has_attached_file :video, :path => ":rails_root/app/assets/:attachment/:id/:basename_:style.:extension",
:url => "/assets/:id/:basename_:style.:extension"
#:styles =>  {:thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}, :medium => { :geometry => "300x300#", :format => 'jpg', :time => 10}}

  validates_attachment_content_type :video,  :content_type => ["video/mp4"], :message => 'Video type is not allowed (only mp4video)'
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
  
end
