class RedisServer
  include Singleton

  REDIS_HOST = Rails.application.credentials[Rails.env.to_sym][:redis_host]
  REDIS_PASSWORD = Rails.application.credentials[Rails.env.to_sym][:redis_password]

  def self.method_missing(method, *args)
    return instance.send(method, *args) if instance.respond_to?(method)
    super
  end

  def initialize
    @redis = Redis.new(host: REDIS_HOST, password: REDIS_PASSWORD)
  end

  def next_chat_number(application_id)
    @redis.incr("application_#{application_id}_chat_number")
  end


  
  
end