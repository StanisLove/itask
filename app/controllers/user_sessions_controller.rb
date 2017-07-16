class UserSessionsController < ApplicationController
  layout 'starting'

  before_action :redirect_authorized, only: [:new, :create]
  skip_before_action :require_auth, only: [:new, :create, :destroy]

  def new
    @login_form = UserLoginForm.new
  end

  def create
    @login_form = UserLoginForm.new(login_form_params)

    if @login_form.valid?
      @user = @login_form.authenticate
      if @user
        session[:user_id] = @user.id.to_s
        session[:role_id] = @user.role.to_s
        flash[:notice] = t('notice.authorized')
        redirect_to root_path
      else
        respond_to do |format|
          flash.now[:alert] = t('users.errors.message.wrong_email_or_password')
          format.html { render :new }
          format.js {}
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js {}
      end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:role_id] = nil
    redirect_to login_path
  end

  private

  def login_form_params
    params.require(:login_form).permit(:email, :password, :remember_me)
  end
end
