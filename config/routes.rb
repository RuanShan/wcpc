Rails.application.routes.draw do
  resource :wechat, only: [:show, :create] do
    collection do
      get :message_box
      get :direct_message_box
    end
  end

  root to: 'visitors#index'
  get '/admin'=>'users#index'
  get '/ranking'=>'visitors#ranking'
  get '/review'=>'visitors#review'
  get '/intro'=>'visitors#intro'
  get '/works'=>'visitors#works'
  get '/my_account'=>'visitors#my_account'
  get '/subscribe'=>'visitors#subscribe'
  get '/show/:id'=>'visitors#show'

  devise_for :users

  resources :users

  resources :shops
  resources :cards
  resources :activities do
    resources :photographs do
      collection do
        get :search
      end
      member do
        get :vote
      end
    end
    #resources :coupons do
    #  collection do
    #    get :search
    #  end
    #end
  end
  namespace :api do
    namespace :v1 do
      resource :wechat, only: [:show, :create]
    end
  end
end
