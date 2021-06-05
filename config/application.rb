require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Ask
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.time_zone = 'Almaty'
    config.load_defaults 5.2
  end
end
