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

require 'rails_helper'

RSpec.describe Application, type: :model do
  context 'validations' do 
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many(:chats).dependent(:destroy) }
  end

  context 'creation' do
    it 'generate unique token in creation' do
      application = create :application
      expect(application.token.present?).to be true 
    end
  end


end
