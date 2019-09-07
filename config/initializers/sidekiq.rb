Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.credentials[Rails.env.to_sym][:redis_host] }
end