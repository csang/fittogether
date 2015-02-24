Rails.application.routes.draw do
  devise_for :admins ,  :controllers => { :sessions => "admin/sessions" ,:registrations => "admin/registrations"}
  root 'landing#index'

  get "/auth/auth0/callback" => "callback#store"
  get "/auth/failure" => "callback#failure"
  
  get 'callback/store'
  get 'callback/failure'
  
  match '/settings/check_user_data/', to: 'settings#check_user_data', :via => [:get,:post] 
  match 'set_remember/(:message)', to: 'callback#set_remember', :via => [:get,:post] , :as=>:set_rememberme
  
  
  get 'login', to: 'landing#login'
  get 'logout', to: 'landing#logout'

  get 'feed/index'
  get 'feed', to: 'feed#index'

  get 'settings/index'
  get 'settings', to: 'settings#index'
  get 'about', to: 'settings#about'
  get 'activities', to: 'settings#activities'
  get 'privacy', to: 'settings#privacy'
  get 'social_settings', to: 'settings#social_settings'
  get 'fitbit', to: 'settings#fitbit'
  get 'support', to: 'settings#support'
  
  get 'admin' , to: "admin/dashboard#index", :via => :get
  get ':id' , to: 'profile#index'
  get ':id/about', to: 'profile#about'
  get ':id/photos', to: 'profile#photos'
  get ':id/videos', to: 'profile#videos'
  get ':id/friends', to: 'profile#friends'
  get ':id/activities', to: 'profile#activities'
  
 
  post 'update_avatar', to:'settings#update_avatar'
  post 'update_profile', to:'settings#update_profile', :as=>:update_profile
  post 'update_privacy', to:'settings#update_privacy', :as=>:update_privacy
  post 'update_activity', to:'settings#update_activity', :as=>:update_activity
  post 'update_about', to:'settings#update_about', :as=>:update_about
  post 'update_social_settings', to:'settings#update_social_settings', :as=>:update_social_settings
  post 'update_trainers_details', to:'settings#update_trainers_details', :as=>:update_trainers_details  
  

  
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
		resources :accounts do
			collection do
				match "search"	, :via => :get
        match "delete_user"	, :via => :post
				match "status"	,:via => :all	
        match "listUsers"	,:via => :get	
       
			end
		end
		resources :tasks do
		  collection do
        get "bulk_actions"
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
