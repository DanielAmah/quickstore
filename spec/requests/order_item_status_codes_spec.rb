require 'rails_helper'

RSpec.describe 'OrderItemStatusCodes API', type: :request do
  # initialize test data 
  let!(:order_item_status_codes) { create_list(:order_item_status_code, 10) }
  let(:order_item_status_code_id) { order_item_status_codes.first.id }

  # Test suite for GET /order_item_status_codes
  describe 'GET /order_item_status_codes' do
    # make HTTP get request before each example
    before { get '/order_item_status_codes' }

    it 'returns order_item_status_codes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /order_item_status_codes/:id
  describe 'GET /order_item_status_codes/:id' do
    before { get "/order_item_status_codes/#{order_item_status_code_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_item_status_code_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:order_item_status_code_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItemStatusCode/)
      end
    end
  end

  # Test suite for POST /order_status_codes
  describe 'POST /order_item_status_codes' do
    # valid payload
    let(:valid_attributes) { { description: 'Out of Stock' } }

    context 'when the request is valid' do
      before { post '/order_item_status_codes', params: valid_attributes }

      it 'creates a todo' do
        expect(json['description']).to eq('Out of Stock')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/order_item_status_codes', params: { description: '' } }

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
  describe 'PUT /order_item_status_codes/:id' do
    let(:valid_attributes) { { description: 'Delivered' } }
    context 'when the record exists' do
      before { put "/order_item_status_codes/#{order_item_status_code_id}", params: valid_attributes }

    
      it 'updates the record' do
        expect(response.body).to match(/OrderItemStatusCode Updated Successfully/) 
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /order_item_status_codes/:id
  describe 'DELETE /order_item_status_codes/:id' do
    before { delete "/order_item_status_codes/#{order_item_status_code_id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end