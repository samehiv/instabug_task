class RedisServer
  include Singleton

  REDIS_HOST = Rails.application.credentials[Rails.env.to_sym][:redis_host]

  def self.method_missing(method, *args)
    return instance.send(method, *args) if instance.respond_to?(method)
    super
  end

  def initialize
    @redis = Redis.new(host: REDIS_HOST)
  end

  def next_chat_number(application)
    @redis.incr("application_#{application.id}_chat_number")
  end

  def next_message_number(chat)
    @redis.incr("chat_#{chat.application_id}_#{chat.id}_message_number")
  end


  
  
end