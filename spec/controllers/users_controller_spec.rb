require 'rails_helper'

describe UsersController do
  specify do
    expect(get: '/signup').to route_to(controller: 'users', action: 'new')
  end

  specify do
    expect(post: '/signup').to route_to(controller: 'users', action: 'create')
  end

  describe "GET #new" do
    subject { get :new }

    it 'renders :new template' do
      expect(subject).to render_template :new
    end

    context "logged in", :user, :login do
      it "redirects to root path" do
        expect(subject).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    let(:email) { Faker::Internet.email }
    let(:form_params) { {} }
    let(:params) { { email: email, password: 'qwerty', password_confirmation: 'qwerty' } }

    subject { post :create, user: params.merge(form_params) }

    it "creates new user" do
      expect { subject }.to change(User.where(email: email), :count).by(1)
    end

    it "create user with common role" do
      expect { subject }.to change(User.where(role: Role.value(:common)), :count).by(1)
    end

    it "redirects to root path" do
      expect(subject).to redirect_to root_path
    end

    context "with invalid params" do
      let(:form_params) { { password_confirmation: 'password' } }

      it "doesn't create user" do
        expect { subject }.to_not change(User, :count)
      end

      it 'renders :new template' do
        expect(subject).to render_template :new
      end
    end

    context "with existed email" do
      before { create :user, email: email }

      it "doesn't create user" do
        expect { subject }.to_not change(User, :count)
      end

      it 'renders :new template' do
        expect(subject).to render_template :new
      end
    end
  end
end
