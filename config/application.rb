require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IMPublisher
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      authentication: ENV['SMTP_SETTINGS_AUTHENTICATION'],
      address: ENV['SMTP_SETTINGS_ADDRESS'],
      port: ENV['SMTP_SETTINGS_PORT'],
      domain: ENV['SMTP_SETTINGS_DOMAIN'],
      user_name: ENV['SMTP_SETTINGS_USER_NAME'],
      password: ENV['SMTP_SETTINGS_PASSWORD']
    }

    config.middleware.use ActionDispatch::Flash
    config.api_only = false
    config.middleware.use Rack::MethodOverride

    config.action_mailer.default_options = { from: ENV['DEFAULT_EMAIL'] }
    config.action_mailer.default_url_options = { host: ENV['DEFAULT_URL_OPTIONS_HOST'] }
  end
end
