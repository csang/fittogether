class Account < ActiveRecord::Base
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
Paperclip.options[:content_type_mappings] = {
  :jpeg => "text/plain"
}
  serialize :goals, Array
	has_one :account_user, :dependent => :delete
    has_one :account_trainer , :dependent => :delete
	has_one :account_gym , :dependent => :delete
	has_many :authorization, :dependent =>:delete_all
	has_many :city
	belongs_to :profession
	has_many :post, :dependent =>:delete_all
	has_many :comment, :dependent =>:delete_all
	has_many :kudo, :dependent =>:delete_all
	has_many :event_kudo, :dependent =>:delete_all
	has_many :event_comment, :dependent =>:delete_all
	has_many :account_cover, :dependent =>:delete_all
	has_one :account_privacy, :dependent =>:delete
	has_one :class_attendance, :dependent =>:delete
	has_many :fitbit, :dependent =>:delete_all
	
	has_many :friendships
  has_many :albums, :dependent =>:delete_all
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendships: { approved: true}) }, :through => :friendships, :source => :friend
  has_many :passive_friends, -> { where(friendships: { approved: true}) }, :through => :passive_friendships, :source => :account
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, :through => :passive_friendships, :source => :account 
  has_many :requested_friendships_seen, -> { where(friendships: { approved: false, seen: false}) }, :through => :passive_friendships, :source => :account 
    
  has_many :conversations, :foreign_key => :sender_id, :dependent =>:delete_all
  has_many :conversation_member
    
  has_many :challenges, :dependent =>:delete_all
  has_many :account_goals, :dependent =>:delete_all
  has_many :passive_challenge, :class_name => "Challenge", :foreign_key => "to_id"
  has_many :requested_challenges_seen, -> { where(challenges: { is_read: false}) }, :through => :passive_challenge, :source => :account 
  has_one :fitbit , :dependent => :delete 
  has_many :group, :dependent =>:delete_all
  has_many :group_member
 
  has_many :raty, :class_name => "Rating", :foreign_key => "trainer_id"
  has_many :rator, :class_name => "Rating", :foreign_key => "account_id"
  has_many :review, :dependent => :delete_all
  has_many :appointment, :dependent => :delete_all
  has_many :tainer_appointments, :class_name => "Appointment", :foreign_key => "trainor_id"
  
  has_many :gym_class, :dependent =>:delete_all
   has_many :gym_class_trainer, :class_name => "gym_class", :foreign_key => "trainer_id"
   has_many :checkin, :dependent =>:delete_all
  
  

  def average_rating
  ar = raty.reject { |n|
			n.score.to_i == 0.0
			 }
	
        raty.sum(:score) / ar.count
  end

  def friends
    active_friends | passive_friends
  end
	
  has_many :account_activity
	has_attached_file :avatar, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :styles => { :medium => "300x300>", :thumb => "160x160>", :large =>"500x500>"  },
    :processors => [:cropper]

  validates_attachment_content_type :avatar, :content_type =>  ["image/png", "image/jpg", "image/jpeg",  "application/octet-stream"],  :message => 'File type is not allowed (only jpeg/png/gif images'
 
#  validates_attachment_content_type :avatar, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'
  # validates :avatar, presence: { message: 'Please select  image'  }
  
  has_attached_file :cover, 
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    :default_url => "group.jpg",
    :styles => { :large => "700x250>" }
    
   validates_attachment_content_type :cover, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)'  
    
	def account_info
		'sweet'
	end
	
   def linked?
    oauth_token.present? 
	end
  
  
  def fitbit_data
	
    raise "Account is not linked with a Fitbit account" unless linked?
       @client ||=  FitgemOauth2::Client.new(
      token: oauth_token,
      client_id: "229GQM",
      client_secret: '90eb02b4ada24d51ada8b0c383793471',
      user_id: uid
    )
   # access_token = @client.reconnect(current_user.token, current_user.secret)
=begin 
    @client ||= FitgemOauth2::Client.new(
     # :client_id => 'c661f3ba999e4314ab3d58dce5d612a7',
      :client_id => '229GQM',
      :client_secret => '90eb02b4ada24d51ada8b0c383793471',
      :token => oauth_token,
     # :secret => access_secret,
      :user_id => uid,
      :ssl => true
    )
=end
  end
	
  def unit_measurement_mappings
    @unit_mappings ||= {
      :distance => @client.label_for_measurement(:distance),
      :duration => @client.label_for_measurement(:duration),
      :elevation => @client.label_for_measurement(:elevation),
      :height => @client.label_for_measurement(:height),
      :weight => @client.label_for_measurement(:weight),
      :measurements => @client.label_for_measurement(:measurements),
      :liquids => @client.label_for_measurement(:liquids),
      :blood_glucose => @client.label_for_measurement(:blood_glucose)
    }
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

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
  
    @geometry ||= {}
  
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  

  def reprocess_avatar
    avatar.reprocess!
  end
 
 
  # cron method
	 def self.cron_fitbit #call from refresh button on right side bar
    puts "cron"
      activity_objects = []
      acc = Fitbit.all
      if acc.present?    
		  acc.each do |usr|	
		 	if usr.account.present? && usr.account.oauth_token.present?			
			client ||=  FitgemOauth2::Client.new(
			  token: usr.account.oauth_token,
			  client_id: "229GQM",
			  client_secret: '90eb02b4ada24d51ada8b0c383793471',
			  user_id: usr.account.uid
			)
			
		    	#  client = usr.account.fitbit_data			
			  #activities = client.activity_time_series(resource: 'calories', start_date: Date.today)
				  activities = client.daily_activity_summary("today")   		  
				  if activities.present?    
					  puts activities['goals']['caloriesOut']
					  puts activities['summary']['caloriesOut']
					  puts activities['goals']['steps']
					  puts activities['goals']['distance']
				
					  @fit = Fitbit.where(:account_id => usr.account.id).first
						if !@fit.present?
						   Fitbit.create(:account_id => usr.account.id, :steps =>activities['goals']['steps'], :calories =>activities['goals']['caloriesOut'], :distance =>activities['goals']['distance'], :summary_calories =>activities['summary']['caloriesOut'])  
					   else       
						  @fit.update_attributes(:steps =>activities['goals']['steps'], :calories =>activities['goals']['caloriesOut'], :distance =>activities['goals']['distance'], :summary_calories =>activities['summary']['caloriesOut'])		
					   end  
						  if Post.create(:account_id=>usr.account.id,:text=>'Fitbit', :status=>1,:share_with=> 'Public',:post_type=> 'fitbit')
							 puts "done " 
						  else
							 puts "not done " 
						  end			  
				 end  
			end 		
		  end 		
     end 		
end
	
  
end
