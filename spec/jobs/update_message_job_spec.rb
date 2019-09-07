require 'rails_helper'

RSpec.describe UpdateMessageJob, type: :job do
  let(:message) do 
    create :message, body: 'old body'
  end

  describe "#perform_now" do
    it('update message') do 
      UpdateMessageJob.perform_now(message, 'new body')
      expect(message.reload.body).to eq('new body')
    end
  end

  describe "#perform_later" do
    it('it queue the job for runing later') do 
      ActiveJob::Base.queue_adapter = :test
      UpdateMessageJob.perform_later(message, 'new body')
      expect(UpdateMessageJob).to have_been_enqueued
    end
  end
end
