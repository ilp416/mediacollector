require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for :user
  }

  let(:invalid_attributes) {
    {email: nil}
  }

  let(:valid_session) { {} }

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET #new" do
    it "assigns a new user as @user by default" do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the user's stuff" do
        post :create, {:user => valid_attributes}, valid_session
        expect(response).to redirect_to(user_staff_path(User.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end
  describe "DELETE #destroy" do

    before :each do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    it "destroys the requested user" do
      expect {
        delete :destroy, {}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, {}, valid_session
      expect(response).to redirect_to('/')
    end
  end
end
