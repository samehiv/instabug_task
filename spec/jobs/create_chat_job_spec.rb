require 'rails_helper'

RSpec.describe CreateChatJob, type: :job do
  describe "#perform_now" do
    it('create chat with giving number') do 
      applcation = create :application
      CreateChatJob.perform_now(applcation, 1)
      expect(applcation.chats.count).to eq(1)
    end
  end

  describe "#perform_later" do
    it('it queue the job for runing later') do 
      applcation = create :application
      ActiveJob::Base.queue_adapter = :test
      CreateChatJob.perform_later(applcation, 1)
      expect(CreateChatJob).to have_been_enqueued
    end
  end
end
