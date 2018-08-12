require 'rails_helper'

RSpec.describe 'Roles API', type: :request do
  let!(:roles) { create_list(:role, 4) }
  let!(:users) { create_list(:user, 4, role_id: roles.first.id) }
  let(:role_id) { roles.first.id }
  let!(:user_id) { users.first.id }
  let(:headers) { valid_headers(users.first.id) }

  describe 'GET /roles' do
    before do
      get '/api/roles', headers: headers
    end

    it 'returns roles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(4)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/roles/:id' do
    before do
      get "/api/roles/#{role_id}", headers: headers
    end

    context 'when the record exists' do
      it 'returns the role' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(role_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:role_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Role/)
      end
    end
  end

  describe 'POST /roles' do
    # valid payload
    let(:valid_attributes) { { role: 'customer', description: 'normal user' }.to_json }

    context 'when the request is valid' do
      before do
        post '/api/roles', params: valid_attributes, headers: headers
      end

      it 'creates a role' do
        expect(json['role']).to eq('customer')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/api/roles', params: { title: 'Bad title' }.to_json, headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Role can't be blank/)
      end
    end
  end

  describe 'PUT /roles/:id' do
    let(:valid_attributes) { { role: 'public', description: 'make rain' }.to_json }

    context 'when the record exists' do
      before do
        put "/api/roles/#{role_id}", params: valid_attributes, headers: headers
      end

      it 'updates the record' do
        obj = JSON(response.body)
        message = obj['message']
        expect(message).to eq('Role Updated Successfully')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /roles/:id' do
    before do
      delete "/api/roles/#{role_id}", headers: headers
    end

    it 'deletes the record' do
      obj = JSON(response.body)
      message = obj['message']
      expect(message).to eq('Role Deleted Successfully')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
