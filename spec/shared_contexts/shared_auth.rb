shared_context "login", login: true do
  before do
    user ||= @user
    session[:user_id] = user.id.to_s
    session[:role_id] = user.role.to_s
  end
end
