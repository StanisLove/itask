shared_context "user", user: true do
  before(:all) { @user ||= create(:user) }
  after(:all) {  @user.try(:delete) }
  let(:user) { @user }
end

shared_context "admin", admin: true do
  before(:all) { @user ||= create(:admin) }
  after(:all) {  @user.try(:delete) }
  let(:user) { @user }
end
