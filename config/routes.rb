Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create]
  resources :session, only: %i[new create destroy]
  resources :subs
  
  resources :posts, except: %i[index] do
    resources :comments, only: %i[new]
  end

  resources :comments, only: %i[create show]
end
