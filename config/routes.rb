Rails.application.routes.draw do
  # devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  authenticated :user do
    root :to => 'events#index', as: :authenticated_root
  end
  root 'home#index'

  get     '/friends'     => 'friends#index',       as: :friends
  get     '/add_friends' => 'friends#add_friends',      as: :add_friends
  post    '/friendships' => 'friendships#create', as: :friendships
  delete  '/friendships/:id' => 'friendships#destroy', as: :unfriend

  scope :api do
    get '/auth' => 'api#auth'
  end

  # get '/users/:id' => 'events#index', as: :user

  # resources :user

  # get '/:user_id/events' => 'events#index', as: :events
end


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
