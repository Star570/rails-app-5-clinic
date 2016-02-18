Rails.application.routes.draw do
  resources :categories
  resources :posts
  resources :announcements
  resources :reservations, except: [:show] do
    collection do
      get :show_user  
      get :finish
      get :modify_seeable
    end
  end

  resources :messages, except: [:edit, :update] do
    resources :comments
  end

  resources :users, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :enter_pin   
      get :finish_register     
      get :change_password   
      post :change_password_verify            
    end
  end
  post 'users/verify_pin' => "users#verify_pin"

  get  'register', to: 'users#new'
  get  'login',    to: 'sessions#new'
  post 'login',    to: 'sessions#create'  
  get  'logout',   to: 'sessions#destroy'

  get   'backstage/reservation_all',  to: 'pages#reservation_all'
  get   'backstage/reservation_list', to: 'pages#reservation_list'  
  get   'backstage/reservation_week', to: 'pages#reservation_week'  
  get   'backstage/user_all',         to: 'pages#user_all'  
  get   'backstage/user_show',        to: 'pages#user_show'    
  get   'backstage/add_user',         to: 'pages#add_user'  
  post  'backstage/add_user',         to: 'pages#create_user'  
  get   'backstage/search_user',      to: 'pages#search_user'  
  get   'backstage/modify_bookable',  to: 'pages#modify_bookable'  

  get   'backstage/add_reservation_s1',  to: 'pages#add_reservation_s1'
  get   'backstage/add_reservation_s2',  to: 'pages#add_reservation_s2'
  post  'backstage/add_reservation_s2',  to: 'pages#create_reservation'  
  get   'backstage/edit_reservation_s2', to: 'pages#edit_reservation_s2'
  patch 'backstage/edit_reservation_s2', to: 'pages#edit_reservation'    
  get   'backstage/add_reservation_s3',  to: 'pages#add_reservation_s3'

  root 'announcements#index'
end
