require 'rails_helper'

RSpec.describe 'OrderStatusCodes API', type: :request do
  let!(:role) { create(:role) }
  let!(:users) { create_list(:user, 4, role_id: role.id) }
  let(:role_id) { role.id }
  let!(:user_id) { users.first.id }
  let!(:order_status_codes) { create_list(:order_status_code, 10) }
  let(:order_status_code_id) { order_status_codes.first.id }
  let(:headers) { valid_headers(users.first.id) }

  # Test suite for GET /order_status_codes
  describe '/api /order_status_codes' do
    # make HTTP get request before each example
    before { get '/api/order_status_codes', headers: headers  }

    it 'returns order_status_codes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /order_status_codes/:id
  describe 'GET /api/order_status_codes/:id' do
    before { get "/api/order_status_codes/#{order_status_code_id}", headers: headers  }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_status_code_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:order_status_code_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderStatusCode/)
      end
    end
  end

  # Test suite for POST /order_status_codes
  describe 'POST /api/order_status_codes' do
    # valid payload
    let(:valid_attributes) { { description: 'Completed' }.to_json }

    context 'when the request is valid' do
      before { post '/api/order_status_codes', params: valid_attributes, headers: headers  }

      it 'creates a todo' do
        expect(json['description']).to eq('Completed')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/order_status_codes', params: { description: '' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /order_status_codes/:id
  describe 'PUT /order_status_codes/:id' do
    let(:valid_attributes) { { description: 'Cancelled' }.to_json }
    context 'when the record exists' do
      before { put "/api/order_status_codes/#{order_status_code_id}", params: valid_attributes , headers: headers }

    
      it 'updates the record' do
        expect(response.body).to match(/OrderStatusCode Updated Successfully/) 
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /order_status_codes/:id
  describe 'DELETE /order_status_codes/:id' do
    before { delete "/api/order_status_codes/#{order_status_code_id}", headers: headers  }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end