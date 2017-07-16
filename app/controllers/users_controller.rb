class UsersController < ApplicationController
  layout 'starting'

  before_action :redirect_authorized, only: [:new, :create]
  skip_before_action :require_auth, only: [:new, :create]

  def new
    @user = User.new
    respond_to do |format|
      format.html { render :new }
      format.js {}
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id.to_s
      session[:role_id] = @user.role.to_s
      redirect_to root_path
    else
      respond_to do |format|
        format.html { render :new }
        format.js {}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email,
                                 :password, :password_confirmation)
  end
end
