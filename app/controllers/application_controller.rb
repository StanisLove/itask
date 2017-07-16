class ApplicationController < ActionController::Base
  include Authorized

  protect_from_forgery with: :exception
end
