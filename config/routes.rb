Rails.application.routes.draw do
    
  # devise_for :users
  # Root path
  root 'products#index'
  devise_for :users, sign_out_via: [:delete, :get]
    resources :categories, only: [:index, :show]

    resources :products, only: [:index, :show] do
      collection do
        get :search
      end
    end


# config/routes.rb
# config/routes.rb
Rails.application.routes.draw do
  resources :orders do
    member do
      get :checkout
      post :confirm
    end
  end
end
    
    


  # Cart routes
  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    patch 'update_item/:id', to: 'carts#update_item', as: :update_item
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end

  # Orders
  resources :orders, only: [:index, :show, :new, :create]

  # Admin namespace
  # namespace :admin do
  #   get 'dashboard', to: 'dashboard#index'
  #   resources :users
  #   resources :products, except: [:show]
  #   resources :categories, except: [:show]
  #   resources :orders, only: [:index, :update]
  # end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy, :show,]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    resources :orders, only: [:index, :show, :update]
  end
  

  # Address management for users
  resources :addresses, only: [:new, :create, :edit, :update]

  # Static pages (optional)
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
end
