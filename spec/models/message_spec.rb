# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :bigint
#
# Indexes
#
#  index_messages_on_chat_id             (chat_id)
#  index_messages_on_chat_id_and_number  (chat_id,number) UNIQUE
#  index_messages_on_number_and_chat_id  (number,chat_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validations' do 
    subject { build :message }
    it { should validate_presence_of(:number) }

    it { should validate_presence_of(:body) }

    it do 
      should validate_uniqueness_of(:number).scoped_to(:chat_id)
    end
  end

  context 'associations' do
    it { should belong_to(:chat) }
  end
end
