class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application, chat_number)
    application.chats.create(number: chat_number)
  end
end
