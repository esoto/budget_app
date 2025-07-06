Rails.application.routes.draw do
  get "transactions/index"
  get "transactions/show"
  get "transactions/new"
  get "transactions/create"
  get "transactions/edit"
  get "transactions/update"
  get "transactions/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Dashboard as root path
  root "dashboard#index"

  # Dashboard routes
  get "dashboard", to: "dashboard#index"

  # Budget management routes
  resources :budgets

  # Transaction routes
  resources :transactions

  # Category routes
  resources :categories
end
