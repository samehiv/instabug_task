require 'rails_helper'

RSpec.describe DestroyMessageJob, type: :job do
  let(:message) do 
    create :message
  end

  describe "#perform_now" do
    it('delete message') do 
      DestroyMessageJob.perform_now(message)
      expect(Message.count).to eq(0)
    end
  end

  describe "#perform_later" do
    it('it queue the job for runing later') do 
      ActiveJob::Base.queue_adapter = :test
      DestroyMessageJob.perform_later(message)
      expect(DestroyMessageJob).to have_been_enqueued
    end
  end
end
