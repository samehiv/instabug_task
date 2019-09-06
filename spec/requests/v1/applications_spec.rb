require 'rails_helper'

RSpec.describe 'V1::Applications', type: :request do
  describe 'GET /v1/applications' do
    before do
      create_list :application, 20
      get v1_applications_path, params: { page: 1, per_page: 5 }, headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return list of applications' do
      expect(json_response[:data][:items].count).to eq(5)
    end
  end

  describe 'GET /v1/applications/:token' do
    let(:application) do
      create(:application)
    end

    before do
      get v1_application_path(application.token), headers: { accept: :json }
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end

    it 'return application by token' do
      expect(json_response[:data][:token]).to eq(application.token)
    end
  end

  describe 'POST /v1/applications' do
    let(:valid_params) do
      { name: 'appliation name' }
    end

    context 'when request is valid' do
      before { post v1_applications_path, params: valid_params, headers: { accept: :json } }

      it 'create application in database' do
        expect(Application.where(name: valid_params[:name]).count).to eq(1)
      end

      it 'return code 200' do
        expect(json_response[:code]).to eq(200)
      end

      it 'return application token' do
        expect(json_response[:data][:token]).to eq(Application.first.token)
      end
    end

    context 'when reuqest is send without name params' do
      before { post v1_applications_path }

      it 'return code 422' do
        expect(json_response[:code]).to eq(422)
      end

      it 'return validation error message' do
        expect(json_response[:errors][0]).not_to be_empty
      end
    end
  end

  describe 'PATCH /v1/applications/:token' do
    let(:valid_params) do
      { name: 'new name' }
    end
    let(:application) do
      create(:application)
    end

    context 'when request is valid' do
      before { patch v1_application_path(application.token), params: valid_params, headers: { accept: :json } }

      it 'update application in database' do
        expect(application.reload.name).to eq('new name')
      end

      it 'return code 200' do
        expect(json_response[:code]).to eq(200)
      end
    end

    context 'update with empty name' do
      before { patch v1_application_path(application.token), params: { name: nil }, headers: { accept: :json } }

      it 'return code 422' do
        expect(json_response[:code]).to eq(422)
      end

      it 'return validation error message' do
        expect(json_response[:errors][0]).not_to be_empty
      end
    end
  end

  describe 'DELETE /v1/applications/:token' do
    let(:application) do
      create(:application)
    end
    before { delete v1_application_path(application.token), headers: { accept: :json } }

    it 'delete application from database' do
      expect{ Application.find(application.token) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return code 200' do
      expect(json_response[:code]).to eq(200)
    end


  end

end
