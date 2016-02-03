Rails.application.routes.draw do
  resources :categories
  resources :posts
  resources :announcements
  resources :messages do
    resources :comments
  end

  get '/news',          to: 'pages#announcements'
  get '/column',        to: 'pages#column'
  get '/message_board', to: 'pages#message_board'
  get '/booking',       to: 'pages#booking' 

  root 'pages#announcements'
end
