require 'rails_helper'

RSpec.describe 'Payments API', type: :request do
  let!(:order_status_code) {create(:order_status_code)}
  let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
  let!(:invoice_status_code) {create(:invoice_status_code)}
  let!(:invoices) {create_list(:invoice, 20, order_id: orders.first.id, invoice_status_code_id: invoice_status_code.id )}
  let!(:payments) {create_list(:payment, 20, invoice_id: invoices.first.id)}
  let(:order_status_code_id) {order_status_code.id}
  let(:order_id) {orders.first.id}
  let(:invoice_status_code_id) {invoice_status_code.id}
  let(:invoice_id) {invoices.first.id}
  let(:id) {payments.first.id}

   # Test suite for GET  /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments
  describe 'GET  /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments" }

    context 'when orders exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all order invoices' do
        expect(json.size).to eq(20)
      end
    end

    context 'when invoice does not exist' do
      let(:invoice_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Invoice/)
      end
    end
  end

  # Test suite for GET /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id
  describe 'GET /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id' do
    before { get "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments/#{id}" }

    context 'when invoice payments exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the payments' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when order invoice does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Payment/)
      end
    end
  end

  # Test suite for POST /categories/:category_id/products/:product_id/order_items
  describe 'POST /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments' do
    let(:valid_attributes) { { date: '2017-12-25', amount: 14999.99, invoice_id: invoices.first.id } }

    context 'when request attributes are valid' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Date can't be blank, Amount can't be blank/)
      end
    end
  end

  # Test suite for PUT /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id
  describe 'PUT /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id' do
    let(:valid_attributes) { { amount: 12000.00 } }

    before { put "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments/#{id}", params: valid_attributes }

    context 'when payment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the payment' do
        updated_payment = Payment.find(id)
        expect(updated_payment.amount).to eq(12000.00)
      end
    end

    context 'when the payment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Payment/)
      end
    end
  end

  # Test suite for DELETE /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id
  describe 'DELETE /order_status_codes/:order_status_code_id/orders/:order_id/invoices/:invoice_id/payments/:id' do
    before { delete "/order_status_codes/#{order_status_code_id}/orders/#{order_id}/invoices/#{invoice_id}/payments/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end