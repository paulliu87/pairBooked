Rails.application.routes.draw do

  resources :challenges, only: [:index] do
    resources :timeslots, except: [:edit, :update] do
      post 'cancel', on: :member
      post 'accept', on: :member
    end
  end

  get '/dashboard', to: "authentication#dashboard"
  get '/logout', to: "authentication#logout"
  post '/login', to: "authentication#login"
  match "/auth/github/callback" => "authentication#login", :via => [:get, :post]
  post '/timezone', to: "authentication#timezone"
  post '/slack_name', to: "authentication#slack_name"

  root to: 'authentication#index'
end
