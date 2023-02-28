Rails.application.routes.draw do
  root to: "user/homes#top"
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}
  devise_for :accounts, controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  scope module: :user do
  get '/about'=>"homes#about"
  resources :illustrations, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :accounts, only: [:show, :edit, :update]
  end
  namespace :admin do
    root "homes#top"
    resources :illustrations, only: [:index, :show, :edit, :update]
    resources :accounts, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
