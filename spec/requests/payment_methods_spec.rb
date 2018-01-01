require 'rails_helper'

RSpec.describe 'Payment Method API', type: :request do
  let!(:role) { create(:role) }
  let!(:users) { create_list(:user, 4, role_id: role.id) }
  let(:role_id) { role.id }
  let!(:user_id) { users.first.id }
  let!(:payment_methods){create_list(:payment_method, 10)}
  let(:payment_method_id){payment_methods.first.id}
  let(:headers) { valid_headers(users.first.id) }

  describe 'GET /api/payment_methods' do
      before {get '/api/payment_methods', headers: headers}
      
      it 'return payment_methods' do 
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
          expect(response).to have_http_status(200)
      end
  end

  describe "GET /api/payment_methods/:id" do
    before{get "/api/payment_methods/#{payment_method_id}", headers: headers}

    context "when the record exists" do
      it 'returns the payment_method' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(payment_method_id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:payment_method_id) {100}

      it "return status 404" do
        expect(response).to have_http_status(404)
      end
      
      it "returns a not found page" do
        expect(response.body).to match(/Couldn't find PaymentMethod/)
      end
        
    end
  
  end

  describe "POST /api/payment_methods" do
    let(:valid_attributes) {{ description: 'credit card'}.to_json}

    context "when the request is valid" do
      before {post '/api/payment_methods', params: valid_attributes, headers: headers}
      it "create a payment_method" do
        expect(json['description']).to eq('credit card')
      end
      
      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
        
    
    end

    context "when the request is invalid" do
      before {post '/api/payment_methods', params: {name: ''}.to_json, headers: headers}

      it "return a status code of 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a valid failure message" do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end

    end

  end

  describe "PUT /payment_methods/:id" do
    let(:valid_attributes) {{description: 'Cash' }.to_json}
    context "when the record exists" do
      before {put "/api/payment_methods/#{payment_method_id}", params: valid_attributes , headers: headers}

      it 'updates the record' do
        expect(response.body).to match(/PaymentMethod Updated Successfully/) 
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /payment_methods/:id' do
    before {delete "/api/payment_methods/#{payment_method_id}", headers: headers}
    it "return status 200" do
      expect(response).to have_http_status(200)
    end
  end

end