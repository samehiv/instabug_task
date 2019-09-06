require 'rails_helper'

RSpec.describe CreateChatJob, type: :job do
  let(:application) do
    create :application
  end

  describe '#perform_now' do
    it('create chat with giving number') do
      CreateChatJob.perform_now(application, 1)
      expect(application.chats.count).to eq(1)
    end
  end

  describe '#perform_later' do
    it('it queue the job for runing later') do
      ActiveJob::Base.queue_adapter = :test
      CreateChatJob.perform_later(application, 1)
      expect(CreateChatJob).to have_been_enqueued
    end
  end
end
