Rails.application.routes.draw do
  resources :uploads
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "users/:id/update" => "users#update"
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'

  get '/' => 'home#top'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
