Rails.application.routes.draw do

  get '/user_search' ,to: 'users#user_search', as: :user_search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root to: 'users#home'

end
