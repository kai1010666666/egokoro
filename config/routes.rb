Rails.application.routes.draw do
  root to: "user/homes#top"
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}
  devise_for :accounts, controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  devise_scope :account do
    post "accounts/guest_sign_in", to: "user/sessions#guest_sign_in"
  end
  scope module: :user do
    get '/about'=>"homes#about"
    get '/rank'=>"homes#rank"
    resources :illustrations do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :accounts, only: [:index, :show, :edit, :update] do
      collection do
        get 'mypage'
      end
    end
    resources :tags, only: [:index, :show]
  end
  namespace :admin do
    root "homes#top"
    resources :illustrations, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :accounts, only: [:index, :show]
    resources :tags, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
