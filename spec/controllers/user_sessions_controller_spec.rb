require 'rails_helper'

describe UserSessionsController do
  specify do
    expect(get: '/login').to route_to(controller: 'user_sessions', action: 'new')
  end

  specify do
    expect(post: '/login').to route_to(controller: 'user_sessions', action: 'create')
  end

  specify do
    expect(get: '/logout').to route_to(controller: 'user_sessions', action: 'destroy')
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

  describe "POST #create", :user do
    let(:params) { { email: user.email, password: 'qwerty' } }

    subject { post :create, login_form: params }

    it "creates user session" do
      expect { subject }.to change { session['user_id'] }.from(nil).to(user.id.to_s)
    end

    it "stores user role in session" do
      expect { subject }.to change { session['role_id'] }.from(nil).to(user.role.to_s)
    end

    it "redirects to root path" do
      expect(subject).to redirect_to root_path
    end

    context "invalid params" do
      let(:params) { { email: user.email, password: 'foo' } }

      it "renders template with errors" do
        expect(subject).to render_template :new
      end
    end
  end

  describe "GET #destroy", :user, :login do
    subject { get :destroy }

    it 'removes user session' do
      expect { subject }.to change { session['user_id'] }.from(user.id.to_s).to(nil)
    end

    it 'removes user role from session' do
      expect { subject }.to change { session['role_id'] }.from(user.role.to_s).to(nil)
    end
  end
end
