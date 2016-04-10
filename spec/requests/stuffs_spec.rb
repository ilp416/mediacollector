require 'rails_helper'

RSpec.describe "Stuffs", type: :request do

  before :each do
    @user = FactoryGirl.create :user
    sign_in @user
    @stuff = FactoryGirl.create :stuff
  end

  describe "GET /stuffs" do
    it "works!" do
      get stuffs_path
      expect(response).to have_http_status(200)
    end
  end
end
