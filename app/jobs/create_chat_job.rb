class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application, number)
    application.chats.create(number: number)
  end
end
