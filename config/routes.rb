Rails.application.routes.draw do

  resources :challenges, only: [:index] do
    resources :timeslots
  end

  get '/dashboard', to: "authentication#dashboard"
  get '/logout', to: "authentication#logout"
  post '/login', to: "authentication#login"
  match "/auth/github/callback" => "authentication#login", :via => [:get, :post]

  root to: 'authentication#index'
end
