require 'rails_helper'

RSpec.describe DestroyChatJob, type: :job do
  let(:chat) do 
    create :chat
  end

  describe "#perform_now" do
    it('delete chat') do 
      DestroyChatJob.perform_now(chat)
      expect(Chat.count).to eq(0)
    end
  end

  describe "#perform_later" do
    it('it queue the job for runing later') do 
      ActiveJob::Base.queue_adapter = :test
      DestroyChatJob.perform_later(chat)
      expect(DestroyChatJob).to have_been_enqueued
    end
  end
end
