Submitter::Application.routes.draw do

  match "/admin" => redirect("/admin/works"), :as => :admin_root

  root :to => 'home#index'
  get "/submit_work" => "home#submit", :as => 'guidelines'
  post "/accept" => "home#accept", :as => :accept
  get "/thank_you" => "home#thank_you"
  
  get "/login" => "sessions#new", :as => :login
  post "/login" => "sessions#create", :as => :do_login
  delete "/logout" => "sessions#destroy", :as => :logout

  resources :works, :except => :destroy do
    post :preview, :on => :collection
    put :preview, :on => :collection
    post :confirm, :on => :member
    get 'page/:page', :action => :index, :on => :collection
  end

  namespace :admin do
    resources :works do
      get 'page/:page', :action => :index, :on => :collection
    end
  end
  get 'admin/csv' => 'admin#csv', :as => 'admin_csv'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
