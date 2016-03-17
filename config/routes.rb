Rails.application.routes.draw do
  resources :categories
  resources :upload_photos, except: [:edit, :update]

  resources :posts do
    collection do
      get :modify_seeable
    end
  end

  resources :announcements do
    collection do
      get :modify_seeable
    end
  end

  resources :reservations, except: [:show, :index, :new, :create] do
    collection do
      get  :hand
      get  :new_hand
      post :create_hand      
      get  :body
      get  :new_body
      post :create_body        
      get  :show_user  
      get  :finish
    end
  end

  resources :messages, except: [:edit, :update] do
    resources :comments
    collection do
      get :modify_seeable
    end    
  end

  resources :users, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :enter_pin   
      get :finish_register     
      get :change_password   
      post :change_password_verify            
    end
    collection do
      get :black
      get :set_black
    end    
  end

  post 'post_photos' => 'post_photos#upload'
  post 'announcement_photos' => 'announcement_photos#upload'

  post 'users/verify_pin' => "users#verify_pin"

  get  'register', to: 'users#new'
  get  'login',    to: 'sessions#new'
  post 'login',    to: 'sessions#create'  
  get  'logout',   to: 'sessions#destroy'

  get   'backstage/hand_reservation_month',  to: 'pages#hand_reservation_month'
  get   'backstage/hand_reservation_list',   to: 'pages#hand_reservation_list'  
  get   'backstage/hand_reservation_week',   to: 'pages#hand_reservation_week'  
  get   'backstage/body_reservation_month',  to: 'pages#body_reservation_month'
  get   'backstage/body_reservation_list',   to: 'pages#body_reservation_list'  
  get   'backstage/body_reservation_week',   to: 'pages#body_reservation_week'
  get   'backstage/user_all',                to: 'pages#user_all'  
  get   'backstage/user_show',               to: 'pages#user_show'    
  get   'backstage/add_user',                to: 'pages#add_user'  
  post  'backstage/add_user',                to: 'pages#create_user'  
  get   'backstage/search_user',             to: 'pages#search_user'  
  get   'backstage/modify_hand_bookable',    to: 'pages#modify_hand_bookable'  
  get   'backstage/modify_body_bookable',    to: 'pages#modify_body_bookable'  

  get   'backstage/add_hand_reservation_s1',      to: 'pages#add_hand_reservation_s1'
  get   'backstage/add_hand_reservation_s2',      to: 'pages#add_hand_reservation_s2'
  post  'backstage/add_hand_reservation_s2',      to: 'pages#create_hand_reservation'  
  get   'backstage/add_hand_reservation_s3',      to: 'pages#add_hand_reservation_s3'  
  get   'backstage/edit_hand_reservation',        to: 'pages#edit_hand_reservation'
  patch 'backstage/edit_hand_reservation',        to: 'pages#update_hand_reservation'    

  get   'backstage/add_body_reservation_s1',      to: 'pages#add_body_reservation_s1'
  get   'backstage/add_body_reservation_s2',      to: 'pages#add_body_reservation_s2'
  post  'backstage/add_body_reservation_s2',      to: 'pages#create_body_reservation'  
  get   'backstage/add_body_reservation_s3',      to: 'pages#add_body_reservation_s3'  
  get   'backstage/edit_body_reservation',        to: 'pages#edit_body_reservation'
  patch 'backstage/edit_body_reservation',        to: 'pages#update_body_reservation'    

  get   'backstage/print_hand_reservation',        to: 'pages#print_hand_reservation'
  get   'backstage/print_body_reservation',        to: 'pages#print_body_reservation'
  
  root 'upload_photos#index'
end
