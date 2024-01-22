require 'sidekiq/web'

Rails.application.routes.draw do
  resources :lcongviec_trangthais do
    
  end
  resources :donvis do
    collection do
      get :new2
      post :create2
    end
    resources :donvi_users
  end
  resources :vanbans do
    resources :vanban_users
  end
  
  resources :boards  do
    member do
      put :sort
    end
    collection do 
      get :new_congviec
      # get :them_lich
      get '/them_lich/:id', to: 'boards#them_lich', as: 'them_lich'
      get :search
      post :create_congviec
    end
    resources :congviecs do
      member do
        put :sort
        # post :invite
      end
      patch :sync_event_with_google, on: :member
      resources :congviec_users
    end
  end

  resources :xemcongviecs do 

  end
  get 'show_congviec/:id' => 'congviecs#show_congviec' , as: 'show_congviec'
  get 'new_congviec_user/:id' => 'congviec_users#new_congviec_user' , as: 'new_congviec_user'
  post 'create_congviec_user/:id' => 'congviec_users#create_congviec_user' , as: 'create_congviec_user'

  delete 'show_congviec/:id' => 'congviecs#destroy_congviec' , as: 'delete_congviec'
  post 'invite_congviec/:id' => 'congviecs#invite_congviec' , as: 'invite_congviec'
  get 'new_congviec' => 'congviecs#new_congviec' 
  post 'create_congviec' => 'congviecs#create_congviec' 
  get 'edit_congviec/:id/edit' => 'congviecs#edit_congviec' , as: 'edit_congviec'
  patch 'update_congviec/:id' => 'congviecs#update_congviec' , as: 'update_congviec'
  get '/check_prefix_congviec', to: 'congviecs#check_prefix_congviec'
  get 'calendar' => 'xemcongviecs#event_calendar'
  get '/home/thongkecongviec', to: 'home#thongkecongviec', as: :thongkecongviec
  get '/home/thongkecongviec2', to: 'home#thongkecongviec2', as: :thongkecongviec2
  # get '/home/form2', to: 'home#form2', as: :form2
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  mount SimpleDiscussion::Engine => "/forum"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  

  root 'home#index'
end
