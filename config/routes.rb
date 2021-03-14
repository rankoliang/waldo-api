Rails.application.routes.draw do
  resources :levels, only: %i[index show]
end
