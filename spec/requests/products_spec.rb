require 'rails_helper'

RSpec.describe 'Product API', type: :request do
    let!(:products){create_list(:product, 10)}
    let(:product_id){products.first.id}

    describe 'GET /products' do
        before {get '/products'}
        
        it 'return products' do 
         expect(json).not_to be_empty
         expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /products/:id" do
        before{get "/products/#{product_id}"}

        context "when the record exists" do
            it 'returns the product' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(product_id)
            end

            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context "when the record does not exist" do
            let(:product_id) {100}

            it "return status 404" do
                expect(response).to have_http_status(404)
            end
            
            it "returns a not found page" do
                expect(response.body).to match(/Couldn't find Product/)
            end
            
        end
    
    end

    describe "POST /products" do
        let(:valid_attributes) {{name: 'boxers', price: 500.00, description: 'comfortable boxer shorts just for you'}}

        context "when the request is valid" do
            before {post '/products', params: valid_attributes}
            it "create a product" do
                expect(json['name']).to eq('boxers')
            end
            
            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
            
        
        end

        context "when the request is invalid" do
            before {post '/products', params: {name: 'Foobar'}}

            it "return a status code of 422" do
                expect(response).to have_http_status(422)
            end

            it "returns a valid failure message" do
                expect(response.body).to match(/Validation failed: Price can't be blank, Description can't be blank/)
            end

        end

    end
    
    describe "PUT /products/:id" do
        let(:valid_attributes) {{name: 'Flowers' }}
      context "when the record exists" do
        before {put "/products/#{product_id}", params: valid_attributes }

        it 'updates the record' do
            expect(response.body).to match(/Product Updated Successfully/) 
        end

        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end
      end
    end

    describe 'DELETE /products/:id' do
        before {delete "/products/#{product_id}"}
        it "return status 200" do
            expect(response).to have_http_status(200)
        end
        
    end
    
    
    
end