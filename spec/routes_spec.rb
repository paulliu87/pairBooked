require 'rails_helper'

RSpec.describe "Routing to authentication", :type => :routing do
  it "routes GET / to authentication#index" do
    expect(:get => "/").to route_to("authentication#index")
  end

  it "routes POST /login to authentication#login" do
    expect(:post => "/login").to route_to("authentication#login")
  end

  it "routes GET /logout to authentication#logout" do
    expect(:get => "/logout").to route_to("authentication#logout")
  end

end
