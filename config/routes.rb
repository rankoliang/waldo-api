Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :levels, only: %i[index show]
    end
  end
end
