require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Itask
  class Application < Rails::Application
    config.active_record.schema_format = :sql

    config.encoding = "utf-8"
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]
    config.i18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework false
    end

    config.autoload_paths += %W(#{config.root}/app/forms/)

    if Rails.env.development?
      console do
        require "pry"
        config.console = Pry
      end
    end
  end
end
