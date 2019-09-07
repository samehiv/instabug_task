require 'rails_helper'

RSpec.describe 'V1::Messages', type: :request do
  describe 'GET /v1/application/:token/chat/:number/messages' do
    before do
      chat = create :chat
      create_list :message, 20, chat: chat
      get v1_application_chat_messages_path(chat.application.token, chat.number),
          params: { page: 1, per_page: 5 }, headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return list of messages' do
      expect(json_response[:data][:items].count).to eq(5)
    end
  end

  describe 'GET /application/:token/chats/:number/messages/:number' do
    let(:message){ create :message }
    before do
      get v1_application_chat_message_path(message.chat.application.token, message.chat.number, message.number),
          params: { page: 1, per_page: 5 }, headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return message' do
      expect(json_response[:data][:number]).to eq(message.number)
    end

  end

end
