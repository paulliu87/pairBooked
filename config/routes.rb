Rails.application.routes.draw do

  resources :challenges, only: [:index] do
    resources :timeslots
  end

  get '/dashboard', to: "authentication#dashboard"
  get '/logout', to: "authentication#logout"
  post '/login', to: "authentication#login"
  get "/auth/github/callback" => "authentication#login"

  root to: 'authentication#index'
end
