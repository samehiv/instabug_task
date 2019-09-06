# == Schema Information
#
# Table name: chats
#
#  id             :bigint           not null
#  messages_count :integer          default(0)
#  number         :integer          primary key
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

FactoryBot.define do
  factory :chat do
    sequence(:number) { |n| n }
    application
  end
end
