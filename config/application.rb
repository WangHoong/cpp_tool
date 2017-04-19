require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CppTool
  class Application < Rails::Application

    config.autoload_paths += Dir["#{config.root}/app/services/"]

    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_types = [:datetime, :time]
  end
end
