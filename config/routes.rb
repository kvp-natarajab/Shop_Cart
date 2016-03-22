Rails.application.routes.draw do
  root :controller => 'home', :action => 'index'
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', sessions: 'devise/sessions', registrations: 'users/registrations' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get "application/autocomplete_product_product_name" => 'application#autocomplete_product_product_name'
  resources :roles
  get 'carts/show' => 'carts#show'
  
  get 'catalog/index'
  # get '/auth/:provider/callback', to: 'sessions#create'
  resources :products
  resources :brands
  resources :categories
  resources :subcategories
  resources :shippers
  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end
  get "/orders/new" => "orders#new"
  get "/products/search/:search_text" => "products#search", as: :search
  get "/products/sub_cat/:id" => "products#subcat"
  get "/products/brand/:id" => "products#brand"
  get "/catalog/sub_cat/:id" => "catalog#brand"
  get "/carts/unit/"  => "carts#unit"
  get "/carts/status/" => "carts#status"
  get "orders/show"  => "orders#show"
  devise_scope :user do
      get "users/sign_out", :to => "devise/sessions#destroy"
  end
  get "users/finish_signup" => "users#finish_signup"
  resources :order_details
  resources :order_statuses
  get "users/edit" => "users#edit"
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
end
