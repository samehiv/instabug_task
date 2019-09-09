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

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  def self.search_query(chat, keyword)
    {
      query: {
        bool: {
          must: [{ term: { chat_id: chat.id } }, { match: { body: keyword } }]
        }
      },
      sort: [{ number: { order: :asc } }]
    }
  end

  validates :number, :body, presence: true
  validates :number, uniqueness: { scope: :chat_id }

  belongs_to :chat, counter_cache: true

  default_scope { order(:number) }

  def as_indexed_json(_options = {})
    as_json(only: %w[body chat_id number])
  end
end
