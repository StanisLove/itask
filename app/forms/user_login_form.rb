class UserLoginForm
  include ActiveModel::Model
  extend ActiveRecord::Validations::ClassMethods
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attr_accessor :email, :password, :remember_me

  validates :email, :password, presence: true
  validates :email, email: true

  def authenticate
    user = User.find_by_email(email)
    user if user && user.authenticate(password)
  end
end
