require 'rails_helper'

RSpec.describe 'Shipments Items API', type: :request do
  let!(:category) {create(:category)}
  let!(:products) {create_list(:product, 20, category_id: category.id)}
  let!(:order_status_code) {create(:order_status_code)}
  let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
  let!(:order_item_status_code) {create(:order_item_status_code)}
  let!(:order_items) {create_list(:order_item, 20, product_id: products.first.id, order_id: orders.first.id, order_item_status_code_id: order_item_status_code.id)}
  let!(:invoice_status_code) {create(:invoice_status_code)}
  let!(:invoices) {create_list(:invoice, 20, order_id: orders.first.id, invoice_status_code_id: invoice_status_code.id )}
  let!(:shipments) {create_list(:shipment, 20, order_id: orders.first.id, invoice_id: invoices.first.id)}
  let!(:shipment_items) {create_list(:shipment_item, 20, shipment_id: shipments.first.id, order_item_id: order_items.first.id)}
  let(:order_status_code_id) {order_status_code.id}
  let(:order_id) {orders.first.id}
  let(:order_item_id) {order_items.first.id}
  let(:invoice_status_code_id) {invoice_status_code.id}
  let(:invoice_id) {invoices.first.id}
  let(:shipment_id) {shipments.first.id}
  let(:id) {shipment_items.first.id}

   # Test suite for GET  /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items
  describe 'GET /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items" }

    context 'when shipments exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order_item shipment_items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when order_item does not exist' do
      let(:order_item_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItem/)
      end
    end
  end

  # Test suite for GET /categories/:category_id/products/:product_id/order_items/:id
  describe 'GET /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items/:id' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items/#{id}" }

    context 'when shipment_items exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when shipment shipment_item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ShipmentItem/)
      end
    end
  end

  # Test suite for POST /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items
  describe 'POST /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items' do
    let(:valid_attributes) { { shipment_id: shipments.first.id, order_item_id: order_items.first.id } }

    context 'when request attributes are valid' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Shipment must exist/)
      end
    end
  end

  # Test suite for PUT /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items
  describe 'PUT /order_status_codes/:order_status_code_id/orders/:order_id//order_items/:order_item_id/shipment_items/:id' do
    let(:valid_attributes) { { shipment_id: 22} }

    before { put "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items/#{id}", params: valid_attributes }

    context 'when shipment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the shipment_item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ShipmentItem/)
      end
    end
  end

  # Test suite for /order_status_codes/:order_status_code_id/order_items/:order_item_id/shipment_items/:id
  describe 'DELETE /order_status_codes/:order_status_code_id/orders/:order_id/order_items/:order_item_id/shipment_items/:id' do
    before { delete "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/order_items/#{order_item_id}/shipment_items/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end