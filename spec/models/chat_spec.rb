# == Schema Information
#
# Table name: chats
#
#  id             :bigint           not null, primary key
#  messages_count :integer          default(0)
#  number         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  application_id :bigint
#
# Indexes
#
#  index_chats_on_application_id             (application_id)
#  index_chats_on_application_id_and_number  (application_id,number) UNIQUE
#  index_chats_on_number_and_application_id  (number,application_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Chat, type: :model do
  context 'validations' do 
    subject { build :chat }
    it { should validate_presence_of(:number) }

    it do 
      should validate_uniqueness_of(:number).scoped_to(:application_id)
    end
  end

  context 'associations' do
    it { should belong_to(:application) }

    it { should have_many(:messages).dependent(:destroy) }

  end


end
