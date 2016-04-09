require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
