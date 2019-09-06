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

class Application < ApplicationRecord
  has_secure_token

  validates :name, presence: true

  has_many :chats, dependent: :destroy
end
