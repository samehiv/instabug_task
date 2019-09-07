class UpdateMessageJob < ApplicationJob
  queue_as :default

  def perform(message, body)
    message.update(body: body)
  end
end
