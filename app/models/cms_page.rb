class CmsPage < ActiveRecord::Base
  
  validates :name,:content,:meta_title, :seo_url, :meta_desc, :meta_keyword, presence: true
end
