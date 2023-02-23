Rails.application.routes.draw do
  devise_for :admins
  devise_for :accounts
  root to: 'homes#top'
  get '/about'=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
