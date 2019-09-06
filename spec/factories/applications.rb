# == Schema Information
#
# Table name: applications
#
#  id          :bigint           not null
#  chats_count :integer          default(0)
#  name        :string(255)
#  token       :string(255)      primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_applications_on_token  (token) UNIQUE
#

FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
  end
end
