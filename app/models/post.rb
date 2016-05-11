class Post < ActiveRecord::Base

belongs_to :account
belongs_to :group
has_many :comment,  :dependent =>:delete_all
has_many :kudos,  :dependent =>:delete_all

=begin
has_many :taggings
has_many :tags, through: :taggings  
=end
  validates_presence_of :account_id
  
has_attached_file :image, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :styles => { :medium => "300x300>", :thumb => "160x160>" }
    
has_attached_file :video, :path => ":rails_root/app/assets/:attachment/:id/:basename_:style.:extension",
:url => "/assets/:id/:basename_:style.:extension"
#:styles =>  {:thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}, :medium => { :geometry => "300x300#", :format => 'jpg', :time => 10}}

  validates_attachment_content_type :video,  :content_type => ["video/mp4"], :message => 'Video type is not allowed (only mp4video)'
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
=begin  
  def text=(names)

    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def text

    self.tags.map(&:name).join(", ")
  end  
=end 
def self.tagged_with(name)
  name = '#' + name
   Post.where("text LIKE ?","%#{name}%")
  
end

end
