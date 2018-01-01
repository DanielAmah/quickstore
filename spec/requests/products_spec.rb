require 'rails_helper'

RSpec.describe 'Products API', type: :request do
    let!(:role) { create(:role) }
    let!(:users) { create_list(:user, 4, role_id: role.id) }
    let(:role_id) { role.id }
    let!(:user_id) { users.first.id }
    let!(:category) {create(:category)}
    let!(:products) {create_list(:product, 20, category_id: category.id)}
    let(:category_id) {category.id}
    let(:id) {products.first.id}
    let(:headers) { valid_headers(users.first.id) }

   # Test suite for GET /api/categories/:category_id/products
  describe 'GET /api/categories/:category_id/products' do
    before { get "/api/categories/#{category_id}/products", headers: headers}

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all category products' do
        expect(json.size).to eq(20)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for GET /api/categories/:category_id/products/:id
  describe 'GET /api/categories/:category_id/products/:id' do
    before { get "/api/categories/#{category_id}/products/#{id}", headers: headers }

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
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for POST /api/categories/:category_id/products
  describe 'POST /api/categories/:category_id/products' do
    let(:valid_attributes) { { name: 'Trousers', price: 1500.99, description: 'The best trousers ever' }.to_json }

    context 'when request attributes are valid' do
      before { post "/api/categories/#{category_id}/products", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/categories/#{category_id}/products", params: {} , headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/todos/:todo_id/items/:id
  describe 'PUT /api/categories/:category_id/products/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before { put "/api/categories/#{category_id}/products/#{id}", params: valid_attributes, headers: headers }

    context 'when product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the product' do
        updated_product = Product.find(id)
        expect(updated_product.name).to match(/Mozart/)
      end
    end

    context 'when the products does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for DELETE /api/categories/:id
  describe 'DELETE /api/categories/:id' do
    before { delete "/api/categories/#{category_id}/products/#{id}", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end 
end