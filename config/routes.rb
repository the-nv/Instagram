Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :posts do
    resources :comments
  end

  get '/timeline', to: 'posts#timeline'

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
