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

FactoryBot.define do
  factory :message do
    sequence(:number) { |n| n }
    body { Faker::Movie.quote }
    chat
  end
end
