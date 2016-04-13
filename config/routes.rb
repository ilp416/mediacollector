Rails.application.routes.draw do

  resources :picture_stuffs, only: :new, controller: :stuffs,
    defaults: {stuff: {type: 'PictureStuff'}}
  resources :url_stuffs, only: :new, controller: :stuffs,
    defaults: {stuff: {type: 'UrlStuff'}}

  resources :picture_stuffs, controller: :stuffs, path: :stuffs
  resources :url_stuffs, controller: :stuffs, path: :stuffs
  resources :stuffs


  devise_scope :user do 
    get '/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post '/sign_up', to: 'devise/registrations#create'
  end
  devise_for :users, only: [:sessions, :passwords], path: '/'
  devise_for :users, only: :registrations, path: '/profile'
  resources :users, except: [:create, :new]

  get 'pages/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'stuffs#index'

  get '/:user_id' => 'stuffs#index', as: 'user_staff'

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
