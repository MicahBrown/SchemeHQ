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
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SchemeHq
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    local_vars_file  = File.join(Rails.root, 'config', 'env.yml')
    yaml_parsed_vars = YAML.load(File.open(local_vars_file)) if File.exists?(local_vars_file)
    yaml_parsed_vars[Rails.env.to_s] && yaml_parsed_vars[Rails.env.to_s].each do |key, value|
      ENV[key.to_s] = value
    end if yaml_parsed_vars.present?
  end
end
