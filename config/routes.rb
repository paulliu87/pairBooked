Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/logout', to: "authentication#logout"
  post '/login', to: "authentication#login"
  get "/auth/:github/callback" => "authentication#login"
  get "/logout" => "authentication#logout", :as => :logout

  root to: 'authentication#index'
end
