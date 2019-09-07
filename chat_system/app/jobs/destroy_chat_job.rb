class DestroyChatJob < ApplicationJob
  queue_as :default

  def perform(chat)
    chat.destroy
  end
end
