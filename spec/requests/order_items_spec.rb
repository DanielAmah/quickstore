require 'rails_helper'

RSpec.describe 'OrderItems API', type: :request do
  let!(:role) { create(:role) }
  let!(:users) { create_list(:user, 4, role_id: role.id) }
  let(:role_id) { role.id }
  let!(:user_id) { users.first.id }
  let!(:category) {create(:category)}
  let!(:products) {create_list(:product, 20, category_id: category.id)}
  let!(:order_status_code) {create(:order_status_code)}
  let!(:orders) {create_list(:order, 20, order_status_code_id: order_status_code.id)}
  let!(:order_item_status_code) {create(:order_item_status_code)}
  let!(:order_items) {create_list(:order_item, 20, product_id: products.first.id, order_id: orders.first.id, order_item_status_code_id: order_item_status_code.id )}
  let(:category_id) {category.id}
  let(:product_id) {products.first.id}
  let(:order_status_code_id) {order_status_code.id}
  let(:order_id) {orders.first.id}
  let(:order_item_status_code_id) {order_item_status_code.id}
  let(:id) {order_items.first.id}
  let(:headers) { valid_headers(users.first.id) }


   # Test suite for GET  /products/:product_id/order_items
  describe 'GET  /categories/:category_id/products/:product_id/order_items' do
    before { get "/api/categories/#{category_id}/products/#{product_id}/order_items", headers: headers }

    context 'when products exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all product order_items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when product does not exist' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for GET /categories/:category_id/products/:product_id/order_items/:id
  describe 'GET /categories/:category_id/products/:product_id/order_items/:id' do
    before { get "/api/categories/#{category_id}/products/#{product_id}/order_items/#{id}", headers: headers }

    context 'when category product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the product' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when category product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItem/)
      end
    end
  end

  # Test suite for POST /categories/:category_id/products/:product_id/order_items
  describe 'POST /categories/:category_id/products/:product_id/order_items' do
    let(:valid_attributes) { { quantity: 20, price: 1500.99, description: 'The best trousers ever', product_id: products.first.id, order_id: orders.first.id, order_item_status_code_id: order_item_status_code.id }.to_json  }

    context 'when request attributes are valid' do
      before { post "/api/categories/#{category_id}/products/#{product_id}/order_items", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/categories/#{category_id}/products/#{product_id}/order_items", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Order must exist, Order item status code must exist, Quantity can't be blank, Price can't be blank/)
      end
    end
  end

  # Test suite for PUT /categories/:category_id/products/:product_id/order_items/:id
  describe 'PUT /api/categories/:category_id/products/:product_id/order_items/:id' do
    let(:valid_attributes) { { quantity: 22 }.to_json }

    before { put "/api/categories/#{category_id}/products/#{product_id}/order_items/#{id}", params: valid_attributes, headers: headers }

    context 'when order item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the order item' do
        updated_product = OrderItem.find(id)
        expect(updated_product.quantity).to eq(22)
      end
    end

    context 'when the order item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItem/)
      end
    end
  end

  # Test suite for /api/categories/:category_id/products/:product_id/order_items/:id
  describe 'DELETE /api/categories/:category_id/products/:product_id/order_items/:id' do
    before { delete "/api/categories/#{category_id}/products/#{product_id}/order_items/#{id}", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end