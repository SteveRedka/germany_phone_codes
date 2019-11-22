Rails.application.routes.draw do
  namespace :api do
    jsonapi_resources :phone_codes
  end
  
  root to: "home#index"
  get "*path", to: "home#index", constraints: { format: "html" }
end
