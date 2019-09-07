require 'rails_helper'

RSpec.describe CreateMessageJob, type: :job do
  let(:chat) do
    create :chat
  end

  describe '#perform_now' do
    it('create message with giving number') do
      CreateMessageJob.perform_now(chat, 1, 'message body')
      expect(chat.messages.count).to eq(1)
    end
  end

  describe '#perform_later' do
    it('it queue the job for runing later') do
      ActiveJob::Base.queue_adapter = :test
      CreateMessageJob.perform_later(chat, 1, 'message body')
      expect(CreateMessageJob).to have_been_enqueued
    end
  end
end
