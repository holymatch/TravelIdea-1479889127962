Rails.application.routes.draw do
  
  post '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#index'
  resources :comments
  resources :ideas
  resources :users
  get '/users/:id/password' => 'users#password'
  patch '/users/:id/password' => 'users#change'
  root :to=>redirect("ideas")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
