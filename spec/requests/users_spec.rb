
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:roles) { create_list(:role, 4) }
  let!(:users) { create_list(:user, 4, role_id: roles.first.id) }
  let(:role_id) { roles.first.id }
  let!(:user_id) { users.first.id }
  let(:headers) { valid_headers(users.first.id) }

  describe 'GET /api/users' do
    before do
      get '/api/users', headers: headers
    end

    it 'returns roles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(4)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/users/:id' do
    before do
      get "/api/users/#{user_id}", headers: headers
    end

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 90 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) { { name: 'Tolulope' }.to_json }
    let(:invalid_attributes) { { name: 'Tolulope', email: users.first.email }.to_json }

    context 'when the record exists' do
      before do
        put "/api/users/#{user_id}", params: valid_attributes, headers: headers
      end

      it 'updates the record' do
        obj = JSON(response.body)
        message = obj['message']
        expect(message).to eq('User Updated Successfully')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when email already exist' do
      before do
        put "/api/users/#{user_id}", params: invalid_attributes, headers: headers
      end

      it 'fails to update' do
        obj = JSON(response.body)
        message = obj['message']
        expect(message).to eq('Email Already Exist')
      end

      it 'returns status code 500' do
        expect(response).to have_http_status(500)
      end
    end
  end

end