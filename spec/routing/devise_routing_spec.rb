require "rails_helper"

RSpec.describe Devise::RegistrationsController, type: :routing do
  describe "routing" do

    it "routes to #cancel" do
      expect(:get => "/profile/cancel").to route_to("devise/registrations#cancel")
    end

    it "routes to #new" do
      expect(:get => "/sign_up").to route_to("devise/registrations#new")
    end

    it "routes to #create" do
      expect(:post => "/sign_up").to route_to("devise/registrations#create")
    end

    it "routes to #edit" do
      expect(:get => "/profile/edit").to route_to("devise/registrations#edit")
    end

    it "routes to #update via PUT" do
      expect(:put => "/profile").to route_to("devise/registrations#update")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/profile").to route_to("devise/registrations#update")
    end

    it "routes to #destroy" do
      expect(:delete => "/profile").to route_to("devise/registrations#destroy")
    end

  end
end


RSpec.describe Devise::SessionsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/sign_in").to route_to("devise/sessions#new")
    end

    it "routes to #create" do
      expect(:post => "/sign_in").to route_to("devise/sessions#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/sign_out").to route_to("devise/sessions#destroy")
    end

  end
end


RSpec.describe Devise::PasswordsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/password/new").to route_to("devise/passwords#new")
    end

    it "routes to #create" do
      expect(:post => "/password").to route_to("devise/passwords#create")
    end

    it "routes to #edit" do
      expect(:get => "/password/edit").to route_to("devise/passwords#edit")
    end

    it "routes to #update via PUT" do
      expect(:put => "/password").to route_to("devise/passwords#update")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/password").to route_to("devise/passwords#update")
    end

  end
end
