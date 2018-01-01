require 'rails_helper'

RSpec.describe 'Category API', type: :request do
  let!(:role) { create(:role) }
  let!(:users) { create_list(:user, 4, role_id: role.id) }
  let(:role_id) { role.id }
  let!(:user_id) { users.first.id }
  let!(:categories){create_list(:category, 10)}
  let(:category_id){categories.first.id}
  let(:headers) { valid_headers(users.first.id) }

  describe 'GET /categories' do
      before do
        get '/api/categories',  headers: headers
      end
      
      it 'return categories' do 
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
          expect(response).to have_http_status(200)
      end
  end

  describe "GET /categories/:id" do
    before{get "/api/categories/#{category_id}",  headers: headers }

    context "when the record exists" do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:category_id) {100}

      it "return status 404" do
        expect(response).to have_http_status(404)
      end
      
      it "returns a not found page" do
        expect(response.body).to match(/Couldn't find Category/)
      end
        
    end
  
  end

  describe "POST /categories" do
    let(:valid_attributes) do 
      { name: 'Furniture', description: 'comfortable clothes just for you'}.to_json
    end

    context "when the request is valid" do
      before do
        post '/api/categories', params: valid_attributes, headers: headers
      end
      it "create a category" do
        expect(json['name']).to eq('Furniture')
      end
      
      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
        
    
    end

    context "when the request is invalid" do
      before do
        post '/api/categories', params: {name: nil}.to_json, headers: headers
      end

      it "return a status code of 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a valid failure message" do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end

    end

  end

  describe "PUT /categories/:id" do
    let(:valid_attributes) {{name: 'Wears' }.to_json}
    context "when the record exists" do
      before {put "/api/categories/#{category_id}", headers: headers }

      it 'updates the record' do
        expect(response.body).to match(/Category Updated Successfully/) 
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /categories/:id' do
    before {delete "/api/categories/#{category_id}",  headers: headers }
    it "return status 200" do
      expect(response).to have_http_status(200)
    end
  end

end