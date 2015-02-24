class Account < ActiveRecord::Base

    serialize :goals, Array
	has_one :account_user, :dependent => :delete
   has_one :account_trainer , :dependent => :delete
	has_one :account_gym , :dependent => :delete
	has_many :authorization, :dependent =>:delete_all
	
  has_many :account_activity
	has_attached_file :avatar, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :styles => { :medium => "300x300>", :thumb => "160x160>" }
 
  validates_attachment_content_type :avatar, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
  # validates :avatar, presence: { message: 'Please select  image'  }
	def account_info
		'sweet'
	end
	
	def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end

	def self.encrypt(string)
      secure_hash("#{string}")
    end
    
    def self.secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

	
  
end
