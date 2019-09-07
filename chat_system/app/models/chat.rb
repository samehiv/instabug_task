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

class Chat < ApplicationRecord

  validates :number, presence: true
  validates :number, uniqueness: { scope: :application_id }

  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  default_scope { order(:number) }
end
