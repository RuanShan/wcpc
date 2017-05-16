Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :shops
  resources :activities do
    resources :photographs
    resources :coupons
  end
end
