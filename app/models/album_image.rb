class AlbumImage < ActiveRecord::Base
belongs_to :album

has_attached_file :image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension"
    #:styles => { :medium => "300x300>", :thumb => "160x160>" }
 
  validates_attachment_content_type :image,
  :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, 
  :message => 'File type is not allowed (only jpeg/png/gif images)',
  :if => :is_type_of_image?

   validates_attachment_content_type :image,
    :content_type => ['video/mp4'],
    :message => "Sorry, right now we only support MP4 video",
    :if => :is_type_of_video?
  
  
  protected
  def is_type_of_video?
    image.content_type =~ %r(video)
  end

  def is_type_of_image?
    image.content_type =~ %r(image)
  end
 
 
 
end
