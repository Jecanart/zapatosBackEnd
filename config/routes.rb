Rails.application.routes.draw do
  resources :images
  
  resources :cart_items do
    collection do
      get 'get_by_cart_id'
    end
  end
  
  resources :products do
    member do
      get 'get_final_price'
      patch 'update_stock'
      patch 'update_discount'
    end

    collection do
      get 'get_by_brand'
      get 'get_by_name'
    end
  end
  
  resources :carts do
    collection do
      get 'get_by_user_id'
    end
  end
  
  resources :users do
    collection do
      get "get_by_mail"
    end
    member do
      patch "update_mail"
    end
    member do
      patch "update_password"
    end
    member do
      patch "update_name"
    end
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
