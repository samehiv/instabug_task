class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat, number, body)
    chat.messages.create(number: number, body: body)
  end
end
