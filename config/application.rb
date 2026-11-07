require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module WellbeingApp
  class Application < Rails::Application
    config.load_defaults 7.1
    config.time_zone = "Paris"
    config.i18n.default_locale = :fr
    config.i18n.available_locales = [:fr, :en]
  end
end
