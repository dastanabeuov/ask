require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Ask
  class Application < Rails::Application
    config.time_zone = 'Almaty'
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       controller_specs: false,
                       helper_specs: false,
                       routng_specs: false,
                       request_specs: false
    end
  end
end
