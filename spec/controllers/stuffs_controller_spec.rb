require 'rails_helper'

RSpec.describe StuffsController, type: :controller do

  before :each do
    @user = FactoryGirl.create :user
    @stuff = FactoryGirl.create :stuff, user_id: @user.id
  end

  let(:valid_attributes) {
    FactoryGirl.attributes_for :stuff, user_id: @user.id
  }

  let(:picture_valid_attributes) {
    picture = Rack::Test::UploadedFile.new(
       Rails.root.join('spec/factories/rails.jpg'),
       'image/jpeg')
    FactoryGirl.attributes_for :stuff,
      user_id: @user.id,
      type: 'PictureStuff',
      picture: picture
  }

  let(:invalid_attributes) { {target_url: ''} }
  let(:valid_session) { {} }



  describe "GET #index without owner" do
    it "assigns all stuffs as @stuffs" do
      get :index, {}, valid_session
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #index" do
    it "assigns all stuffs as @stuffs" do
      get :index, {user_id: @user.id}, valid_session
      expect(assigns(:stuffs)).to eq([@stuff])
    end
  end

  describe "GET #show" do
    it "assigns the requested stuff as @stuff" do
      get :show, {:id => @stuff.to_param}, valid_session
      expect(assigns(:stuff)).to eq(@stuff)
    end
  end

  context 'with authorized user' do
    before :each do
      sign_in @user
    end

    describe "GET #new" do
      it "assigns a new url_stuff as @stuff by default" do
        get :new, {}, valid_session
        expect(assigns(:stuff)).to be_a_new(Stuff)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Stuff" do
          expect {
            post :create, {:stuff => valid_attributes}, valid_session
          }.to change(Stuff, :count).by(1)
        end

        it "assigns a newly created stuff as @stuff" do
          post :create, {:stuff => valid_attributes}, valid_session
          expect(assigns(:stuff)).to be_a(Stuff)
          expect(assigns(:stuff)).to be_persisted
        end

        it "assigns a newly created picture stuff as @stuff" do
          post :create, {:stuff => picture_valid_attributes}, valid_session
          expect(assigns(:stuff)).to be_a(Stuff)
          expect(assigns(:stuff)).to be_persisted
        end

        it "redirects to the created stuff" do
          post :create, {:stuff => valid_attributes}, valid_session
          expect(response).to redirect_to( stuffs_url)
        end
      end

      # Stuff haven't invalid attributes
      #context "with invalid params" do
      #  it "assigns a newly created but unsaved stuff as @stuff" do
      #    post :create, {stuff: invalid_attributes}, valid_session
      #    expect(assigns(:stuff)).to be_a_new(Stuff).with type: 'UrlStuff'
      #  end

      #  it "re-renders the 'new' template" do
      #    post :create, {:stuff => invalid_attributes}, valid_session
      #    expect(response).to render_template("new")
      #  end
      #end
    end

    describe "GET #edit" do
      it "redirects to the unauthorized url" do
        get :edit, {:id => @stuff.to_param}, valid_session
        expect(assigns(:stuff)).to eq(@stuff)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {description: 'New description'}
        }

        it "updates the requested stuff" do
          put :update, {:id => @stuff.to_param, :stuff => new_attributes}, valid_session
          @stuff.reload
          expect(@stuff.description).to eq new_attributes[:description]
        end

        it "assigns the requested stuff as @stuff" do
          put :update, {:id => @stuff.to_param, :stuff => valid_attributes}, valid_session
          expect(assigns(:stuff)).to eq(@stuff)
        end

        it "redirects to the stuff" do
          put :update, {:id => @stuff.to_param, :stuff => valid_attributes}, valid_session
          expect(response).to redirect_to(@stuff)
        end
      end

      context "with invalid params" do
        it "assigns the stuff as @stuff" do
          put :update, {:id => @stuff.to_param, :stuff => invalid_attributes}, valid_session
          expect(assigns(:stuff)).to eq(@stuff)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => @stuff.to_param, :stuff => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested stuff" do
        expect {
          delete :destroy, {:id => @stuff.to_param}, valid_session
        }.to change(Stuff, :count).by(-1)
      end

      it "redirects to the stuffs list" do
        delete :destroy, {:id => @stuff.to_param}, valid_session
        expect(response).to redirect_to(stuffs_url)
      end
    end
  end

  context 'with unauthorized user' do
    before :each do
      signed_user = FactoryGirl.create :user
      sign_in signed_user
    end

    describe "GET #edit" do
      it "redirects to the unauthorized url" do
        get :edit, {:id => @stuff.to_param}, valid_session
        expect(response).to redirect_to(root_url)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
        {description: 'wrong_description'}
      }
      it "redirects to the unauthorized url" do
        put :update, {:id => @stuff.to_param, :stuff => new_attributes}, valid_session
        expect(@stuff.description).not_to eq 'wrong_description'
        expect(response).to redirect_to(root_url)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the stuffs list" do
        delete :destroy, {:id => @stuff.to_param}, valid_session
        expect(@stuff.persisted?).to be true
        expect(response).to redirect_to(root_url)
      end
    end
  end


  context 'with unauthenticated user' do

    describe "GET #new" do
      it "redirects to the unauthorized url" do
        get :new, {}, valid_session
        expect(response).to redirect_to(root_url)
      end
    end

    describe "POST #create" do
      it "redirects to the unauthorized url" do
        expect {
          post :create, {:stuff => valid_attributes}, valid_session
        }.to change(Stuff, :count).by(0)
        expect(response).to redirect_to(root_url)
      end
    end

    describe "GET #edit" do
      it "redirects to the unauthorized url" do
        get :edit, {:id => @stuff.to_param}, valid_session
        expect(response).to redirect_to(root_url)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
        {description: 'wrong_description'}
      }
      it "redirects to the unauthorized url" do
        put :update, {:id => @stuff.to_param, :stuff => new_attributes}, valid_session
        expect(@stuff.description).not_to eq 'wrong_description'
        expect(response).to redirect_to(root_url)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the stuffs list" do
        delete :destroy, {:id => @stuff.to_param}, valid_session
        expect(@stuff.persisted?).to be true
        expect(response).to redirect_to(root_url)
      end
    end
  end


end
