require 'rails_helper'

RSpec.describe 'Shipments API', type: :request do
  let!(:role) { create(:role) }
  let!(:users) { create_list(:user, 4, role_id: role.id) }
  let(:role_id) { role.id }
  let!(:user_id) { users.first.id }
  let!(:order_status_code) {create(:order_status_code)}
  let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
  let!(:invoice_status_code) {create(:invoice_status_code)}
  let!(:invoices) {create_list(:invoice, 20, order_id: orders.first.id, invoice_status_code_id: invoice_status_code.id )}
  let!(:shipments) {create_list(:shipment, 20, order_id: orders.first.id, invoice_id: invoices.first.id)}
  let(:order_status_code_id) {order_status_code.id}
  let(:order_id) {orders.first.id}
  let(:invoice_status_code_id) {invoice_status_code.id}
  let(:invoice_id) {invoices.first.id}
  let(:id) {shipments.first.id}
  let(:headers) { valid_headers(users.first.id) }

   # Test suite for GET  /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments
  describe 'GET  /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments' do
    before { get "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments" , headers: headers }

    context 'when orders exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order shipments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when order does not exist' do
      let(:order_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # Test suite for GET /categories/:category_id/products/:product_id/order_items/:id
  describe 'GET /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments/:id' do
    before { get "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments/#{id}" , headers: headers }

    context 'when order invoices exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the shipments' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when order shipment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Shipment/)
      end
    end
  end

  # Test suite for POST /order_status_codes/:order_status_code_id/orders/:order_id/shipments
  describe 'POST /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments' do
    let(:valid_attributes) { { tracking_number: "81948962600014", date: '2017-12-25', description: 'My description', order_id: orders.first.id, invoice_id: invoices.first.id }.to_json }

    context 'when request attributes are valid' do
      before { post "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Invoice must exist, Tracking number can't be blank, Date can't be blank/)
      end
    end
  end

  # Test suite for PUT /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id
  describe 'PUT /api/order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id' do
    let(:valid_attributes) { { tracking_number: "81948962600013"}.to_json }

    before { put "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments/#{id}", params: valid_attributes, headers: headers }

    context 'when shipment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the shipment' do
        updated_shipment = Shipment.find(id)
        expect(updated_shipment.tracking_number).to eq("81948962600013")
      end
    end

    context 'when the shipment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Shipment/)
      end
    end
  end

  # Test suite for /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments:id
  describe 'DELETE /api/order_status_codes/:order_status_code_id/orders/:order_id/shipments/:id' do
    before { delete "/api/order_status_codes/#{order_status_code_id}/orders/#{order_id}/shipments/#{id}", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end