Rails.application.routes.draw do
  resource :wechat, only: [:show, :create] do
    collection do
      get :message_box
      get :direct_message_box
    end
  end
  root to: 'visitors#index'
  get '/ranking'=>'visitors#ranking'
  get '/intro'=>'visitors#intro'
  get '/show/:id'=>'visitors#show'

  devise_for :users

  resources :users

  resources :shops
  resources :activities do
    resources :photographs do
      collection do
        get :search
      end
      member do
        get :vote
      end
    end
    resources :coupons do
      collection do
        get :search
      end
    end
  end

end
