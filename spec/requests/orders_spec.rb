require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
    let!(:role) { create(:role) }
    let!(:users) { create_list(:user, 4, role_id: role.id) }
    let(:role_id) { role.id }
    let!(:user_id) { users.first.id }
    let!(:order_status_code) {create(:order_status_code)}
    let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
    let(:order_status_code_id) {order_status_code.id}
    let(:id) {orders.first.id}
    let(:headers) { valid_headers(users.first.id) }

   # Test suite for GET /api/order_status_codes/:order_status_code_id/orders
  describe 'GET /api/order_status_codes/:order_status_code_id/orders' do
    before { get "/api/order_status_codes/#{order_status_code_id}/orders", headers: headers }

    context 'when order_status_code exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order_status_code orders' do
        expect(json.size).to eq(20)
      end
    end

    context 'when order_status_code does not exist' do
      let(:order_status_code_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderStatusCode/)
      end
    end
  end

  # Test suite for GET /api/order_status_codes/:order_status_code_id/orders/:id
  describe 'GET /api/order_status_codes/:order_status_code_id/orders/:id' do
    before { get "/api/order_status_codes/#{order_status_code_id}/orders/#{id}", headers: headers }

    context 'when order_status_code orders exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the order' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when order_status_code order does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # Test suite for POST /api/categories/:category_id/products
  describe 'POST /api/order_status_codes/:order_status_code_id/orders' do
    let(:valid_attributes) { { date: '2011-07-14', description: 'another other' }.to_json }

    context 'when request attributes are valid' do
      before { post "/api/order_status_codes/#{order_status_code_id}/orders", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/order_status_codes/#{order_status_code_id}/orders", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Date can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/order_status_codes/:order_status_code_id/orders/:id
  describe 'PUT /api/order_status_codes/:order_status_code_id/orders/:id' do
    let(:valid_attributes) { { description: 'Completed' }.to_json }

    before { put "/api/order_status_codes/#{order_status_code_id}/orders/#{id}", params: valid_attributes, headers: headers }

    context 'when orders exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the order' do
        updated_product = Order.find(id)
        expect(updated_product.description).to match(/Completed/)
      end
    end

    context 'when the orders does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # Test suite for DELETE /categories/:id
  describe 'DELETE /api/order_status_codes/:id' do
    before { delete "/api/order_status_codes/#{order_status_code_id}/orders/#{id}" , headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end