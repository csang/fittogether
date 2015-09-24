Rails.application.routes.draw do

 
 
 
  get 'reviews/index'
  get 'reviews/new' 
  post 'reviews/creat' 

  namespace :admin do
    resources :feedbacks
  end

  get 'challenges', to: 'challenges#index'
  #patch 'cupdate', to: 'challenges#update',:as => :challange_update
  match 'challenge/', :to=>'challenges#create',:via => [:post,:get] ,  :as => :challenge
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
  get 'fitspots/index'
  get 'fitspots/:id', to: 'fitspots#show'  
  post 'fitspots/create'

 
 
  match 'add_del_member', to: 'groups#add_del_member', :via => [:get,:post,:delete] , :as => :add_del_member
  match 'create_group_post', to: 'groups#create_group_post', :via => [:post] , :as=>:create_group_post  
  match 'group_request', to: 'groups#group_request', :via => [:put,:delete] , :as => :group_request
  get 'groups/:id', to: 'groups#show'
  post 'groups/create'
  get 'groups/index'
 match 'groups/edit/(:id)', to: 'groups#edit',:via => [:patch,:get], :as=>:groups_edit
  

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

  
  match '/settings/check_user_data/', to: 'settings#check_user_data', :via => [:get,:post] 
  match 'get_gym_address', to: 'settings#get_gym_address', :via => [:get,:post], :as => :get_address 
  match 'set_remember/(:message)', to: 'callback#set_remember', :via => [:get,:post] , :as=>:set_rememberme
  match 'create_comment', to: 'feed#create_comment', :via => [:post] , :as=>:create_comment
  match 'create_post', to: 'feed#create_post', :via => [:post] , :as=>:create_post
  match 'search_people/:search', to: 'profile#search_people', :via => [:post] , :as=>:searchpeople
  match 'addfriend', to: 'friendships#friend_request', :via => [:post] , :as => :addfriend
  match 'cancelrequest', to: 'friendships#friend_request_cancel', :via => [:delete] , :as => :cancelrequest
  match 'rejectrequest', to: 'friendships#friend_request_reject', :via => [:delete] , :as => :rejectrequest
  match 'acceptrequest', to: 'friendships#friend_request_accept', :via => [:put] , :as => :acceptrequest
  
  match 'deleteimage/(:imgid)', to: 'feed#delete_image', :via => [:delete] , :as => :deleteimage
  match 'deletepost', to: 'feed#delete_post', :via => [:delete] , :as => :deletepost
  match 'deletecomment/', to: 'feed#delete_comment', :via => [:delete] , :as => :deletecomment
  
  post 'createalbum', to:'feed#create_album', :as=>:createalbum  
  get 'showalbum/:id', to:'feed#show_album', :as=>:showalbum  
  post 'update_album', to:'feed#update_album', :as=>:update_album  
  get 'un_sync', to:'feed#un_sync', :as=>:un_sync  
  match 'send_feedback', to: 'feed#send_feedback', :via => [:post] , :as => :send_feedback
  
  
  
  
  get 'login', to: 'landing#login'
  get 'logout', to: 'landing#logout'

  get 'feed/index'
  get 'feed', to: 'feed#index'
  get 'tags/:tag', to: 'feed#index', as: "tag"

  #post 'update_post', to: 'feed#update_post',:as=>:update_post
  

  get 'settings/index'
  get 'settings', to: 'settings#index'
  get 'about', to: 'settings#about'
  get 'activities', to: 'settings#activities'
  get 'privacy', to: 'settings#privacy'
  get 'social_settings', to: 'settings#social_settings'
  get 'fitbit', to: 'settings#fitbit'
  get 'support', to: 'settings#support'
  get 'email_notification_settings', to: 'settings#email_notification_settings'
  
  get 'admin' , to: "admin/dashboard#index", :via => :get
  get ':id' , to: 'profile#index', :as=>:profile  
  get ':id/about', to: 'profile#about'
  get ':id/photos', to: 'profile#photos'
  get ':id/videos', to: 'profile#videos'
  get ':id/appointments', to: 'profile#appointments'
  get ':id/reviews', to: 'profile#reviews'
  get ':id/friends', to: 'profile#friends'
  get ':id/activities', to: 'profile#activities'
  get ':id/members', to: 'profile#members'
  get ':id/notifications', to: 'profile#notifications'
  
  get 'getgymaddress', to: 'settings#get_gym_address/:id'
  post 'update_avatar', to:'settings#update_avatar'
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
