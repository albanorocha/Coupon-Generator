Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'getcoupon/:coupon_id', to: 'visitors#getcoupon', as: 'getcoupon'
  post 'getcoupon/:coupon_id', to: 'visitors#redeem'
  get 'code/:coupon_code', to: 'visitors#coupon_code', as: 'coupon_code'
  
  get 'coupons/:coupon_id', to: 'visitors#show', as: 'show_coupon'

  
  namespace :admin do
    root to: 'coupons#index'
    resources :coupons

    resources :users, except: 'session' do
      member do
        get 'edit_password', to: 'users#edit_password'
        patch 'user_password', to: 'users#update_password'
        put 'user_password', to: 'users#update_password'
      end
    end

    #get 'redeemed_coupons', to: 'redeemed_coupons#index'
    #delete 'redeemed_coupon/:id', to: 'redeemed_coupons#destroy'
    resources :redeemed_coupons, only: [:index, :destroy] do
      member do
        post 'validate', to: 'redeemed_coupons#validate'
      end
    end
  end

  resources :users, only: 'session'
  devise_for :users, :skip => [:registrations]
end
