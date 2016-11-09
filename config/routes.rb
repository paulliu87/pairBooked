Rails.application.routes.draw do

  resources :challenges, only: [:index] do
    resources :timeslots, except: [:edit, :update]
  end

  get '/dashboard', to: "authentication#dashboard"
  get '/logout', to: "authentication#logout"
  post '/login', to: "authentication#login"
  match "/auth/github/callback" => "authentication#login", :via => [:get, :post]
  get '/timezone', to: "authentication#timezone_form"
  post '/timezone', to: "authentication#timezone"

  root to: 'authentication#index'
end
