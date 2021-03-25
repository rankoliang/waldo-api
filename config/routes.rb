Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :levels, only: %i[index show] do
        resources :scores, only: %i[index create], path: 'leaderboard', as: 'leaderboard'
        resources :characters, only: [:index]
        get '/search_areas/:id/search', to: 'search_areas#show', as: 'search'
      end
    end
  end
end
