Rails.application.routes.draw do

 
 
 
  post 'events/create'
  match 'give_event_kudos', to: 'events#give_event_kudos', :via => [:post] , :as=>:create_event_kudos
  match 'create_comment_on_event', to: 'events#create_comment_on_event', :via => [:post] , :as=>:give_comment_on_event
  match 'event_comment_delete/', to: 'events#delete_event_comment', :via => [:delete] , :as => :event_comment_delete
  match 'add_del_attending', to: 'events#add_del_attending', :via => [:post,:delete] , :as => :add_del_attending
  get 'events/show'
  match 'event_delete/:id', to: 'events#destroy', :via => [:delete] , :as => :event_delete

  get 'account_covers/new'

  get 'account_covers/create'
  
   match 'account_cover/', :to=>'account_covers#create',:via => [:post,:get] ,  :defaults => { :format => 'json' }, :as => :account_covers
   match 'update_cover_offset/', :to=>'account_covers#update_cover_offset',:via => [:post] ,  :as => :update_cover_offset
   match 'fitspot_cover/', :to=>'fitspots#fitspot_cover',:via => [:post,:get] ,  :defaults => { :format => 'json' }, :as => :fitspot_covers
   
   

   get 'gym_trainer_appointments/new'

  post 'gym_trainer_appointments/create'

  get 'gym_trainer_appointments/update'

  get 'gym_trainer_appointments/delete'

  get 'gym_classes/new'

  get 'gym_classes/create'

  get 'gym_classes/update'

  get 'gym_classes/delete'
  match 'get_counts/', :to=>'gym_classes#classes_count_for_date',:via => [:get] ,  :as => :get_counts
  match 'get_classes/', :to=>'gym_classes#get_classes',:via => [:get] ,  :as => :get_classes
  match 'show_classes_details/', :to=>'gym_classes#show_classes_details',:via => [:get] ,  :as => :show_classes_details
  match 'get_class_slot/', :to=>'gym_classes#get_class_slot',:via => [:get] ,  :as => :get_class_slot
  match 'attend_class/', :to=>'gym_classes#attend_class',:via => [:post] ,  :as => :attend_class
  
  match 'remove_from_class/', :to=>'gym_classes#remove_from_class',:via => [:post] ,  :as => :remove_from_class
  match 'get_weekly_appointment/', :to=>'gym_trainer_appointments#get_weekly_appointment',:via => [:get] 
  match 'get_working_trainer/', :to=>'gym_trainer_appointments#get_working_trainer',:via => [:get] ,  :as => :get_working_trainer
  
  match 'get_appointment_count/', :to=>'gym_trainer_appointments#get_appointment_count',:via => [:get] ,  :as => :get_appointment_count

  get 'reviews/index'
  get 'reviews/new' 
  post 'reviews/creat' 

  namespace :admin do
    resources :feedbacks
  end
  #resources :gym_classes
  get 'challenges', to: 'challenges#index'
  #patch 'cupdate', to: 'challenges#update',:as => :challange_update
  match 'challenge/', :to=>'challenges#create',:via => [:post,:get] ,  :as => :challenge
  match 'gym_class/', :to=>'gym_classes#create',:via => [:post,:get] ,  :as => :gym_classes
  match 'deletechallenge', to: 'challenges#del_challenge', :via => [:delete] , :as => :deletechallenge
  match 'changechallengestatus/:cid/:status', to: 'challenges#change_challenge_status', :via => [:get, :post] , :as => :changechallengestatus
  match 'updaterewardpoints/(:cid)/(:account_id)', to: 'challenges#update_reward_points', :via => [:get, :post] , :as => :updaterewardpoints
  get "challenges/show" => "challenges#show_team_challenge" 
  match 'challenges/edit/(:id)', to: 'challenges#edit',:via => [:patch,:get], :as=>:challenges_edit
  match 'search_user/:search/(:type)/(:uid)/(:request_page)/(:conv_id)', to: 'challenges#search_user', :via => [:post] , :as=>:searchuser
  
  get 'goals', to: 'goals#index'
  match 'goal/', :to=>'goals#create',:via => [:post,:get] ,  :as => :account_goals
  match 'deletegoal', to: 'goals#del_goal', :via => [:delete] , :as => :deletegoal
  match 'changegoalestatus/:cid/:status', to: 'challenges#change_goal_status', :via => [:get, :post] , :as => :changegoalstatus
  get 'goals/show' 
  match 'goals/edit/(:id)', to: 'goals#edit',:via => [:patch,:get], :as=>:goals_edit
 
  

 

  get 'messages/create'
  match '/messages/(:sender_id)/(:recipient_id)/(:body)', :to => 'messages#create', :via => [:post,:get] , :as => :messages
  match 'sendmessage', to: 'messages#send_message', :via => [:post] , :as => :sendmessage
  match 'get_last_five_msg', to: 'messages#get_last_five_msg', :via => [:get,:post] , :as => :get_last_five_msg
  match 'get_chat_box_values', to: 'messages#get_chat_box_values', :via => [:get,:post] , :as => :get_chat_box_values
  match 'checkmsgcount', to: 'messages#checkmsgcount', :via => [:get, :post] , :as => :checkmsgcount
  match 'deletemessage', to: 'messages#del_message', :via => [:delete] , :as => :deletemessage
  match 'autocomplete', to: 'messages#autocomplete', :via => [:get, :post] , :as => :autocomplete
  get '/check', to: 'messages#check'
   
  match 'getconv', to: 'conversations#getconv', :via => [:get, :post] , :as => :getconv
  match 'deleteconv', to: 'conversations#del_conversation', :via => [:delete] , :as => :deleteconv
  match 'updatestatus/(:cid)', to: 'conversations#updatestatus', :via => [:get, :post] , :as => :updatestatus
  match 'create_group_conv', to: 'conversations#create_group_conv', :via => [:get, :post] , :as => :create_group_conv
  match 'add_del_going', to: 'fitspots#add_del_going', :via => [:post,:delete] , :as => :add_del_going
  match 'invite_for_fitspot', to: 'fitspots#invite_for_fitspot', :via => [:post,:delete] , :as => :invite_for_fitspot
  match 'fitspots/edit/(:id)', to: 'fitspots#edit',:via => [:patch,:get], :as=>:fitspots_edit
  match '/fitspot/:id/(:type)', to: 'fitspots#show', :via => [:get,:post] , :as => :fs 
  get 'fitspots/index'
  get 'fitspots/:id/(:events)', to: 'fitspots#show'  
  post 'fitspots/create'

 
 
  match 'add_del_member', to: 'groups#add_del_member', :via => [:get,:post,:delete] , :as => :add_del_member
  match 'create_group_post', to: 'groups#create_group_post', :via => [:post] , :as=>:create_group_post  
  match 'group_request', to: 'groups#group_request', :via => [:put,:delete] , :as => :group_request
  match 'fitspot_request', to: 'fitspots#fitspot_request', :via => [:put,:delete] , :as => :fitspot_request
 
  post 'groups/create'
  match '/groups/:id/(:type)', to: 'groups#show', :via => [:get,:post] , :as => :gp 
  get 'groups/index'
  match 'groups/edit/(:id)', to: 'groups#edit',:via => [:patch,:get], :as=>:groups_edit
  
  match 'update_group_cover_offset/', :to=>'groups#update_cover_offset',:via => [:post] ,  :as => :update_group_cover_offset
  match 'update_fitspot_cover_offset/', :to=>'fitspots#update_fitspot_cover_offset',:via => [:post] ,  :as => :update_fitspot_cover_offset
   match 'group_cover/', :to=>'groups#group_cover',:via => [:post,:get] ,  :defaults => { :format => 'json' }, :as => :group_covers
   match 'invite_for_group', to: 'groups#invite_for_group', :via => [:post,:delete] , :as => :invite_for_group


  get 'conversations/create'
  get 'conversations/show'
  get 'conversations/(:cid)', to: 'conversations#index', :as=> :conversations

  devise_for :admins ,  :controllers => { :sessions => "admin/sessions" ,:registrations => "admin/registrations"}
  root 'landing#index'

  get "/auth/auth0/callback" => "callback#store"
  get "/auth/failure" => "callback#failure"
  
  get 'callback/store'
  get 'callback/failure'
 
  get "/invites/:provider/contact_callback" => "invites#index"
	get "/contacts/failure" => "invites#failure"
  match 'send_invitations', to: 'invites#send_invitations', :via => [:post] , :as => :send_nvitations

  
  match 'delete_account', to: 'settings#delete_account', :via => [:delete], :as => :delete_account
  match '/settings/check_user_data/', to: 'settings#check_user_data', :via => [:get,:post] 
  match 'get_gym_address', to: 'settings#get_gym_address', :via => [:get,:post], :as => :get_address 
  match 'set_remember/(:message)', to: 'callback#set_remember', :via => [:get,:post] , :as=>:set_rememberme
  match 'create_comment', to: 'feed#create_comment', :via => [:post] , :as=>:create_comment
  match 'give_kudos', to: 'feed#give_kudos', :via => [:post] , :as=>:create_kudos
  match 'create_post', to: 'feed#create_post', :via => [:post] , :as=>:create_post
  match 'search_people/:search', to: 'profile#search_people', :via => [:post] , :as=>:searchpeople
  match 'addfriend', to: 'friendships#friend_request', :via => [:post] , :as => :addfriend
  match 'cancelrequest', to: 'friendships#friend_request_cancel', :via => [:delete] , :as => :cancelrequest
  match 'rejectrequest', to: 'friendships#friend_request_reject', :via => [:delete] , :as => :rejectrequest
  match 'acceptrequest', to: 'friendships#friend_request_accept', :via => [:put] , :as => :acceptrequest
  
  match 'deleteimage/(:imgid)', to: 'feed#delete_image', :via => [:delete] , :as => :deleteimage
  match 'deletepost', to: 'feed#delete_post', :via => [:delete] , :as => :deletepost
  match 'editpost', to: 'feed#edit_post', :via => [:put] , :as => :editpost
  match 'deletecomment/', to: 'feed#delete_comment', :via => [:delete] , :as => :deletecomment
  
  post 'createalbum', to:'feed#create_album', :as=>:createalbum  
  get 'showalbum/:id', to:'feed#show_album', :as=>:showalbum  
  post 'update_album', to:'feed#update_album', :as=>:update_album  
  match 'delete_album/:id', to:'feed#delete_album',:via => [:delete], :as=>:delete_album  
  get 'un_sync', to:'feed#un_sync', :as=>:un_sync  
  match 'send_feedback', to: 'feed#send_feedback', :via => [:post] , :as => :send_feedback
  match 'check_in', to: 'feed#check_in', :via => [:post] , :as => :check_in
  match 'scrap_link', to: 'feed#scrap_link', :via => [:post] , :as => :scrap_link
  
   match 'fitspot_check_in', to: 'fitspots#fitspot_check_in', :via => [:post] , :as => :fitspot_check_in
  
  
  
  
  get 'login', to: 'landing#login'
  get 'logout', to: 'landing#logout'

  get 'feed/index'
  get 'feed', to: 'feed#index'
  get 'tags/:tag', to: 'feed#index', as: "tag"

  #post 'update_post', to: 'feed#update_post',:as=>:update_post
  

  get 'settings/index'
  get 'settings', to: 'settings#index'
  get 'crop', to: 'settings#crop'
  get 'about', to: 'settings#about'
  get 'activities', to: 'settings#activities'
  get 'privacy', to: 'settings#privacy'
  get 'social_settings', to: 'settings#social_settings'
  get 'fitbit', to: 'settings#fitbit'
  get 'support', to: 'settings#support'
  get 'email_notification_settings', to: 'settings#email_notification_settings'
   get 'dashboard', to: 'profile#dashboard'
   get 'classes', to: 'profile#classes'
   get 'appointments', to: 'profile#gym_admin_appointments'
   get 'trainors', to: 'profile#gym_trainors'
   get 'members', to: 'profile#gym_members'
  get 'admin' , to: "admin/dashboard#index", :via => :get
  get ':id' , to: 'profile#index', :as=>:profile  
  get ':id/about', to: 'profile#about'
  get ':id/photos', to: 'profile#photos'
  get ':id/videos', to: 'profile#videos'
  get ':id/appointments', to: 'profile#appointments'
  get ':id/reviews', to: 'profile#reviews'
  get ':id/classes', to: 'profile#show_classes'
  get ':id/friends', to: 'profile#friends'
  get ':id/activities', to: 'profile#activities'
  get ':id/members', to: 'profile#members'
  get ':id/trainers', to: 'profile#trainers'
  get ':id/notifications', to: 'profile#notifications'
  get ':id/suggested_friends', to: 'profile#suggested_friends'
 
  match 'profile/new_friends_and_members', to: 'profile#new_friends_and_members',:via => [:get], :defaults => { :format => 'json' }
  match 'get_check_in_count', to: 'profile#get_check_in_count',:via => [:get, :post], :defaults => { :format => 'json' }, :as=>:get_check
  match 'get_most_active_members', to: 'profile#get_most_active_members',:via => [:get, :post], :defaults => { :format => 'json' }, :as=>:get_most_active_members
  
  get 'getgymaddress', to: 'settings#get_gym_address/:id'
  post 'update_avatar', to:'settings#update_avatar'
  patch 'update_crop', to:'settings#update_crop', :as=>:update_crop
  match 'update_cover', to:'profile#update_cover',:via => [:post]
  post 'update_profile', to:'settings#update_profile', :as=>:update_profile
  post 'update_privacy', to:'settings#update_privacy', :as=>:update_privacy
  post 'update_activity', to:'settings#update_activity', :as=>:update_activity
  post 'update_about', to:'settings#update_about', :as=>:update_about
  post 'update_social_settings', to:'settings#update_social_settings', :as=>:update_social_settings
  post 'update_trainers_details', to:'settings#update_trainers_details', :as=>:update_trainers_details  
  post 'update_about_gym', to:'settings#update_about_gym', :as=>:update_about_gym  
  post 'update_email_settings', to:'settings#update_email_settings', :as=>:update_email_settings
  
 
  get '/get_user_appointment/:id/(:pid)' => 'appointments#get_user_appointment', :as =>:get_user_appointment
  post '/save_user_appointment' => 'appointments#save_user_appointment', :as =>:save_user_appointment
  delete '/delete_user_event/:id' => 'appointments#delete_user_event', :as =>:delete_user_event
  put '/approve_user_event/:id' => 'appointments#approve_user_event', :as =>:approve_user_event
 
  
  resources :ratings, only: :update
 
  resources :friendships do
	  member do
      put 'friend_request'
      put 'friend_request_accept'
      delete 'friend_request_cancel'
	  end
	end
	
  # Routes for the api interfaces
  namespace :api do
    get 'activity', controller: 'activities', action: 'index'
    get 'fitness_tracking', controller: 'activities', action: 'fitness_tracking'
    match 'create_update_goal', controller: 'activities', action: 'create_update_goal',:via => [:get, :post]
    get 'body_measurements', controller: 'body_measurements', action: 'show'   
    resources :activities, only: [:index]
    # resources :foods, only: [:index]
   
     namespace :v1   do 
		    post 'accounts/store', controller: 'accounts', action: 'store',:defaults => { :format => 'json' } 	
		    post 'accounts/login', controller: 'accounts', action: 'login',:defaults => { :format => 'json' }  
		    post 'accounts/signup', controller: 'accounts', action: 'signup',:defaults => { :format => 'json' }  

		    
		 # resources :accounts, :defaults => { :format => 'json' }   
		
		  resources :feeds, :defaults => { :format => 'json' }  
	      get 'feeds/get_posts/:account_id', controller: 'feeds', action: 'get_posts',:defaults => { :format => 'json' }  
	      post 'feeds/create_post', controller: 'feeds', action: 'create_post',:defaults => { :format => 'json' }  
	      post 'feeds/destroy_post', controller: 'feeds', action: 'destroy_post',:defaults => { :format => 'json' }
	      post 'feeds/create_album', controller: 'feeds', action: 'create_album',:defaults => { :format => 'json' }
	      get 'feeds/show_album/:id/:account_id', controller: 'feeds', action: 'show_album',:defaults => { :format => 'json' }
	      post 'feeds/delete_record', controller: 'feeds', action: 'delete_record',:defaults => { :format => 'json' }
	      post 'feeds/update_album', controller: 'feeds', action: 'update_album',:defaults => { :format => 'json' }
	      post 'feeds/create_comment', controller: 'feeds', action: 'create_comment',:defaults => { :format => 'json' }
	      post 'feeds/delete_comment', controller: 'feeds', action: 'delete_comment',:defaults => { :format => 'json' }
	      post 'feeds/send_feedback', controller: 'feeds', action: 'send_feedback',:defaults => { :format => 'json' }
	      # settings controller api methods 
	      get 'settings/privacy', controller: 'settings', action: 'privacy',:defaults => { :format => 'json' }
	      post 'settings/update_privacy', controller: 'settings', action: 'update_privacy',:defaults => { :format => 'json' }
	      match 'settings/update_social_settings', to: 'settings#update_social_settings', :via => [:post, :get] ,:defaults => { :format => 'json' }
	      post 'settings/update_about_settings', to: 'settings#update_about_settings', :defaults => { :format => 'json' }
	      get 'settings/show_about_settings', controller: 'settings', action: 'show_about_settings',:defaults => { :format => 'json' }
	      post 'settings/update_about_gym', controller: 'settings', action: 'update_about_gym',:defaults => { :format => 'json' }
	      post 'settings/update_about_trainers', controller: 'settings', action: 'update_about_trainers',:defaults => { :format => 'json' }
	      post 'settings/update_avatar', controller: 'settings', action: 'update_avatar',:defaults => { :format => 'json' }
	      post 'settings/update_profile', controller: 'settings', action: 'update_profile',:defaults => { :format => 'json' }
	      
	      match 'settings/get_update_activity', controller: 'settings', action: 'get_update_activity', :via =>[:get, :post] , :defaults =>  { :format => 'json' }
	      post 'settings/update_email_settings', controller: 'settings', action: 'update_email_settings',  :defaults =>  { :format => 'json' }
	      get 'settings/email_notification_settings', controller: 'settings', action: 'email_notification_settings',  :defaults =>  { :format => 'json' }
	      get 'settings/check_user_data', controller: 'settings', action: 'check_user_data',  :defaults =>  { :format => 'json' }
	      # profile routings
	      get 'profiles/index', controller: 'profiles', action: 'index',:defaults => { :format => 'json' }
	      get 'profiles/about', controller: 'profiles', action: 'about',:defaults => { :format => 'json' }
	      get 'profiles/photos', controller: 'profiles', action: 'photos',:defaults => { :format => 'json' }
	      get 'profiles/activities', controller: 'profiles', action: 'activities',:defaults => { :format => 'json' }
	      get 'profiles/members', controller: 'profiles', action: 'members',:defaults => { :format => 'json' }
	      get 'profiles/search_all', controller: 'profiles', action: 'search_all',:defaults => { :format => 'json' }
	      get 'profiles/notifications', controller: 'profiles', action: 'notifications',:defaults => { :format => 'json' }
	      get 'profiles/reviews', controller: 'profiles', action: 'reviews',:defaults => { :format => 'json' }
	      # create review
	      post 'reviews/create/', controller: 'reviews', action: 'create_review',:defaults => { :format => 'json' }
	      # friendship friendrequest method routs
	      post 'friendships/friend_request', controller: 'friendships', action: 'friend_request',:defaults => { :format => 'json' }
	      post 'friendships/friend_request_cancel', controller: 'friendships', action: 'friend_request_cancel',:defaults => { :format => 'json' }
	      post 'friendships/friend_request_reject', controller: 'friendships', action: 'friend_request_reject',:defaults => { :format => 'json' }
	      put 'friendships/friend_request_accept', controller: 'friendships', action: 'friend_request_accept',:defaults => { :format => 'json' }
	      # group 	
	      post 'groups/create', controller: 'groups', action: 'create',:defaults => { :format => 'json' }
	      put 'groups/edit', controller: 'groups', action: 'edit',:defaults => { :format => 'json' }
	      get 'groups/show', controller: 'groups', action: 'show',:defaults => { :format => 'json' }
	      post 'groups/add_del_member', controller: 'groups', action: 'add_del_member',:defaults => { :format => 'json' }
	      post 'groups/create_group_post', controller: 'groups', action: 'create_group_post',:defaults => { :format => 'json' }
	      post 'groups/group_request', controller: 'groups', action: 'group_request',:defaults => { :format => 'json' }
	      
	      # fitspot 
	      get 'fitspots/index', controller: 'fitspots', action: 'index',:defaults => { :format => 'json' }	
	      post 'fitspots/create', controller: 'fitspots', action: 'create',:defaults => { :format => 'json' }	
	      put 'fitspots/edit', controller: 'fitspots', action: 'edit',:defaults => { :format => 'json' }	
	      get 'fitspots/show', controller: 'fitspots', action: 'show',:defaults => { :format => 'json' }	
	      post 'fitspots/add_del_going', controller: 'fitspots', action: 'add_del_going',:defaults => { :format => 'json' }	
	      post 'fitspots/invite_for_fitspot', controller: 'fitspots', action: 'invite_for_fitspot',:defaults => { :format => 'json' }	
	        # chellege 
	      post 'challenges/create', controller: 'challenges', action: 'create',:defaults => { :format => 'json' }	
	      get 'challenges/show_team_challenge', controller: 'challenges', action: 'show_team_challenge',:defaults => { :format => 'json' }	
	      put 'challenges/del_challenge', controller: 'challenges', action: 'del_challenge',:defaults => { :format => 'json' }	
	      put 'challenges/change_challenge_status', controller: 'challenges', action: 'change_challenge_status',:defaults => { :format => 'json' }	
	      put 'challenges/update_reward_points', controller: 'challenges', action: 'update_reward_points',:defaults => { :format => 'json' }	
	      get 'challenges/search_user', controller: 'challenges', action: 'search_user',:defaults => { :format => 'json' }	
	      # goals 
	      post 'goals/create', controller: 'goals', action: 'create',:defaults => { :format => 'json' }	
	      get 'goals/index', controller: 'goals', action: 'index',:defaults => { :format => 'json' }	
	      delete 'goals/delete_goal', controller: 'goals', action: 'delete_goal',:defaults => { :format => 'json' }	
	      put 'goals/change_goal_status', controller: 'goals', action: 'change_goal_status',:defaults => { :format => 'json' }	
	      match 'goals/edit', controller: 'goals', action: 'edit',:via => [:post, :get] ,:defaults => { :format => 'json' }		      
	      # Appointment routings
	      get 'appointments/get_user_appointment', controller: 'appointments', action: 'get_user_appointment',:defaults => { :format => 'json' }
	      post 'appointments/save_user_appointment', controller: 'appointments', action: 'save_user_appointment',:defaults => { :format => 'json' }
	      delete 'appointments/delete_user_event', controller: 'appointments', action: 'delete_user_event',:defaults => { :format => 'json' }
	      post 'appointments/approve_user_event', controller: 'appointments', action: 'approve_user_event',:defaults => { :format => 'json' }
	       # Rating routings
	      post 'raitings/update', controller: 'raitings', action: 'update',:defaults => { :format => 'json' }
	       # Conversation routings
	      get 'conversations/index', controller: 'conversations', action: 'index',:defaults => { :format => 'json' }
	      get 'conversations/show', controller: 'conversations', action: 'show',:defaults => { :format => 'json' }
	      post 'conversations/create', controller: 'conversations', action: 'create',:defaults => { :format => 'json' }
	      post 'conversations/updatestatus', controller: 'conversations', action: 'updatestatus',:defaults => { :format => 'json' }
	      delete 'conversations/del_conversation', controller: 'conversations', action: 'del_conversation',:defaults => { :format => 'json' }
	      post 'conversations/create_group_conv', controller: 'conversations', action: 'create_group_conv',:defaults => { :format => 'json' }
	      
	       # Messages routings
	       post 'messages/create', controller: 'messages', action: 'create',:defaults => { :format => 'json' }
	       post 'messages/send_message', controller: 'messages', action: 'send_message',:defaults => { :format => 'json' }
	       get 'messages/checkmsgcount', controller: 'messages', action: 'checkmsgcount',:defaults => { :format => 'json' }
	       delete 'messages/del_message', controller: 'messages', action: 'del_message',:defaults => { :format => 'json' }
	       get 'messages/get_last_five_msg', controller: 'messages', action: 'get_last_five_msg',:defaults => { :format => 'json' }
	       get 'messages/get_chat_box_values', controller: 'messages', action: 'get_chat_box_values',:defaults => { :format => 'json' }
	     
	      
	      
	      
		 
	 end
	
	
  end	

  # get 'landing/login'
	     	     
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  #get "admins/change_password", :to =>'admin/registrations#edit', :as => :changepassword
    
  # match "admin/database_list",:as => :admin_dashboard_list
    
	get "admins", to: "admin/users#new", :via => :get ,:as => :admin_sign_in
	
	namespace :admin do
		resources :dashboard	
      resources :feedbacks	 do
      	collection do
				match "search" 	, :via => :post
    end
    end
		resources :cms_pages	 do
      	collection do
				match "search"	, :via => :get
    end
    end
    	resources :locations	 do
      	collection do
				match "search"	, :via => :get
         post 'add_city', to:'locations#add_city', :as=>:add_city
         match 'update_city', to:'locations#update_city',:via => [:get ,:post], :as=>:update_city
         match 'delete_city', to:'locations#delete_city',:via => [:delete], :as=>:delete_city
    end
    end
  
		resources :accounts do
			collection do
				match "search"	, :via => :get
        match "delete_user"	, :via => :post
				match "status"	,:via => :all	
        match "listUsers"	,:via => :get	
        match "gym_management"	,:via => :get	
        match "show_gym/(:id)", to:"accounts#show_gym"	,:via => [:get, :post]	,  :as =>:show_gym
        match "edit_gym/(:id)", to:"accounts#edit_gym"	,:via => [:get, :put], :as =>:edit_gym
       
			end
		end
		
    resources :tasks do
		  collection do
        get "bulk_actions"
		  end
		end	
    
    resources :photos do
		  collection do
        match "search"	, :via => :get
        match "listPhotos"	,:via => :get	
       
		  end
		end	
    
	end
    
  match ':controller(/:action(/id))', :via => :get
  match "*path", to: "errors#error_404", via: :all
  
  if Rails.env.production? then
    unless Rails.application.config.consider_all_requests_local
      get '*not_found', to: 'errors#error_404'
      get '*internal_server_error', to: 'errors#error_500'
    end
  else
    unless
      get '*not_found', to: 'errors#error_404'
      get '*internal_server_error', to: 'errors#error_500'
    end
  end
  
  match ':controller(/:action(/id))', :via => :get
end
