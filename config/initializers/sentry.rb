Raven.configure do |config|
  # sentry dsn
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = ['development', 'staging', 'production']
end