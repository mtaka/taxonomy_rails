require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaxonomyBuilder
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Autoload #2017.08.31
    config.paths.add 'lib', eager_load: true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # 2017.09.02 Switched to API mode
    # https://railsguides.jp/api_app.html
    config.api_only = true

    # 2017.09.03 Allowing Cross Domain Access
    # http://qiita.com/tentenmitsunori/items/dbe80b5ead421cac8d2f
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

  end
end
