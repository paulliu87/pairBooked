Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  p "Hello"
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], scope: "user"
end
