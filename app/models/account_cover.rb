class AccountCover < ActiveRecord::Base

belongs_to :account

has_attached_file :cover, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :styles => lambda {|a| a.instance.styles }

  # the styles to be used by paperclip resizing
  def styles
   if position == 1 || position == 2
       { :medium => "175x150>" }
  elsif position == 3
       { :medium => "350x150>" }  
  elsif position == 4
       { :medium => "350x300>" }          
  else
       { :medium => "175x150>" }
  end
 end
 validates_attachment_content_type :cover,
  :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, 
  :message => 'File type is not allowed (only jpeg/png/gif images)'   
  
 
 end
  
 
