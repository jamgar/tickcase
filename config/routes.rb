Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  scope "/admin" do
    resources :users
  end

  get '/about', to: "pages#about"
  get '/contact', to: "pages#contact"
  get '/secret', to: "pages#secret"
  get '/tickets/closed', to: "tickets#closed"

  resources :tickets do
    resources :ticket_messages
  end

  authenticated :user do
    root 'tickets#index', as: :authenticated_root
  end

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
