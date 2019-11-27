Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :phone_codes
    end
  end

  root to: "home#index"
  get "*path", to: "home#index", constraints: { format: "html" }
end
