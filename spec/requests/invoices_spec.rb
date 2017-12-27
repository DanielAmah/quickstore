require 'rails_helper'

RSpec.describe 'Invoices API', type: :request do
  let!(:order_status_code) {create(:order_status_code)}
  let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
  let!(:invoice_status_code) {create(:invoice_status_code)}
  let!(:invoices) {create_list(:invoice, 20, order_id: orders.first.id, invoice_status_code_id: invoice_status_code.id )}
  let(:order_status_code_id) {order_status_code.id}
  let(:order_id) {orders.first.id}
  let(:invoice_status_code_id) {invoice_status_code.id}
  let(:id) {invoices.first.id}

   # Test suite for GET  /order_status_codes/:order_status_code_id/orders/:order_id/invoices
  describe 'GET  /order_status_codes/:order_status_code_id/orders/:order_id/invoices' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices" }

    context 'when orders exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order invoices' do
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
  describe 'GET /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{id}" }

    context 'when order invoices exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the invoices' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when order invoice does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Invoice/)
      end
    end
  end

  # Test suite for POST /categories/:category_id/products/:product_id/order_items
  describe 'POST /order_status_codes/:order_status_code_id/orders/:order_id/invoices' do
    let(:valid_attributes) { { date: '2017-12-25', description: 'The best trousers ever', order_id: orders.first.id, invoice_status_code_id: invoice_status_code.id } }

    context 'when request attributes are valid' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Invoice status code must exist, Date can't be blank/)
      end
    end
  end

  # Test suite for PUT /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id
  describe 'PUT /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id' do
    let(:valid_attributes) { { description: 'make your payment' } }

    before { put "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{id}", params: valid_attributes }

    context 'when invoice exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the invoice' do
        updated_product = Invoice.find(id)
        expect(updated_product.description).to match(/make your payment/)
      end
    end

    context 'when the invoice does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Invoice/)
      end
    end
  end

  # Test suite for /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id
  describe 'DELETE /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:id' do
    before { delete "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end