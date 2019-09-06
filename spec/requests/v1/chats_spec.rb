require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'GET /application/:token/chats' do
    before do
      application = create :application
      create_list :chat, 20, application: application
      get v1_application_chats_path(application.token), params: { page: 1, per_page: 5 }, headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return list of applications' do
      expect(json_response[:data][:items].count).to eq(5)
    end
  end

  describe 'GET /application/:token/chats/:number' do
    let(:chat){ create :chat }
    before do
      get v1_application_chat_path(chat.application.token, chat.number),
          params: { page: 1, per_page: 5 }, headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return chat' do
      expect(json_response[:data][:number]).to eq(chat.number)
    end

  end

  describe 'POST /application/:token/chats' do
    let(:application) { create :application }
    before do
      clear_enqueued_jobs
      post v1_application_chats_path(application.token), headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return chat number' do
      expect(json_response[:data][:chat_number].present?).to eq(true)
    end

    it 'it queue create chat job for runing later' do
      expect(CreateChatJob).to have_been_enqueued
    end
  end
end
