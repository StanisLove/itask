require 'spec_helper'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require 'capybara/rspec'
require 'factory_girl_rails'
require 'timecop'
# require 'webmock/rspec'
# require 'email_spec'
# require 'with_model'
# require 'pundit/rspec'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/shared_contexts/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Rails.logger = ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV["LOG"].present?

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # config.include JsonSpec::Helpers
  # config.include ShowMeTheCookies, type: :feature
  # config.include OauthHelper
  # config.include GoogleImagesHelper
  # config.include EmailSpec::Helpers
  # config.include EmailSpec::Matchers, type: :mailer

  # config.extend WithModel
  # config.extend TbHelper
  # config.extend PolicyHelper, type: :policy
  # config.extend ControllerHelper, type: :request
  # config.extend ControllerHelper, type: :controller
  # config.extend EndpointHelpers, type: :request

  config.filter_run_excluding(regression: true) unless ENV['R'].present?
  # config.filter_run_excluding(type: :feature) unless ENV['F'].present? ||
  #                                                   ARGV.find { |arg| arg =~ /spec\/features\// }
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace 'active_model_serializers'

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }

  config.before(:each) { DatabaseCleaner.strategy = :transaction }

  config.before(:each) { DatabaseCleaner.start }
  # config.before(:each, truncate: true) { DatabaseCleaner.clean_with :truncation }

  # config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }

  # Turn off notifications by default
  # config.before(:each) { Notification.suppress! }

  # config.before(:each, notify: true) { Notification.unsuppress! }

  # config.before(:each) { WebMock.disable_net_connect! }

  # config.after(:each, notify: true) { Notification.suppress! }

  config.after(:each) do
    Timecop.return
    # clean any previously set test config for DomainResolver
    # DomainResolver.test!
    # clear identity cache
    # IdentityCache.cache.clear
    # Clear Rails cache
    Rails.cache.clear
  end

  config.after(:each) { DatabaseCleaner.clean }

  config.after(:suite) do
    # delete attachments
    FileUtils.rm_rf Rails.root.join("public/system_test#{ENV['TEST_ENV_NUMBER'] || ''}")
    # delete latex temp files
    # FileUtils.rm_rf Rails.root.join("tmp/latex/test#{ENV['TEST_ENV_NUMBER'] || ''}")
  end

  config.infer_spec_type_from_file_location!

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.use_transactional_fixtures = false
end
