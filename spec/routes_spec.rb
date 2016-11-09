require 'rails_helper'

RSpec.describe "Routing to authentication", :type => :routing do

  it "routes POST /login to authentication#login" do
    expect(:post => "/login").to route_to("authentication#login")
  end

  it "routes GET /logout to authentication#logout" do
    expect(:get => "/logout").to route_to("authentication#logout")
  end

  it "routes GET /dashboard to authentication#dashboard" do
    expect(:get => "/dashboard").to route_to("authentication#dashboard")
  end

  it "routes POST /timezone to authentication#timezone" do
    expect(:post => "/timezone").to route_to("authentication#timezone")
  end

  it "routes GET / to authentication#index" do
    expect(:get => "/").to route_to("authentication#index")
  end
end

RSpec.describe "Routing to challenges", :type => :routing do
  it "routes GET /challenges to challenges#index" do
    expect(:get => "/challenges").to route_to("challenges#index")
  end
end

RSpec.describe "Routing to timeslots", :type => :routing do
  it "routes GET /challenges/:id/timeslots to challenges#index" do
    expect(:get => "/challenges/1/timeslots").to route_to("timeslots#index", :challenge_id => "1")
  end

  it "routes GET /challenges/:id/timeslots/new to timeslots#new" do
    expect(:get => "/challenges/1/timeslots/new").to route_to("timeslots#new", :challenge_id => "1")
  end

  it "routes POST /challenges/:id/timeslots to timeslots#create" do
    expect(:post => "/challenges/1/timeslots").to route_to("timeslots#create", :challenge_id => "1")
  end

  it "routes GET /challenges/:id/timeslots/:id to timeslots#show" do
    expect(:get => "/challenges/1/timeslots/1").to route_to("timeslots#show", "challenge_id"=>"1", "id"=>"1")
  end

  it "routes DELETE /challenges/:id/timeslots/:id to timeslots#destroy" do
    expect(:delete => "/challenges/1/timeslots/1").to route_to("timeslots#destroy", "challenge_id"=>"1", "id"=>"1")
  end
end
