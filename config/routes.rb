Rails.application.routes.draw do
  resources :categories
  resources :posts
  resources :announcements
  resources :reservations, except: [:show, :edit, :update] do
    collection do
      get :select
      get :find
      get :list 
    end
  end

  resources :messages, except: [:edit, :update] do
    resources :comments
  end

  root 'announcements#index'
end
