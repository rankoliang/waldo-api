Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :levels, only: %i[index show] do
        resources :scores, only: %i[index create], path: 'leaderboard', as: 'leaderboard'
        resources :characters, only: [:index]
        get '/characters/:id/search', to: 'characters#search', as: 'search'
      end
    end
  end
end
