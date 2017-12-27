require 'rails_helper'

RSpec.describe 'InvoiceStatusCode API', type: :request do
  let!(:invoice_status_codes){create_list(:invoice_status_code, 10)}
  let(:invoice_status_code_id){invoice_status_codes.first.id}

  describe 'GET /invoice_status_codes' do
      before {get '/invoice_status_codes'}
      
      it 'return invoice_status_codes' do 
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
          expect(response).to have_http_status(200)
      end
  end

  describe "GET /invoice_status_codes/:id" do
    before{ get "/invoice_status_codes/#{invoice_status_code_id}" }

    context "when the record exists" do
      it 'returns the invoice_status_code' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(invoice_status_code_id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:invoice_status_code_id) {100}

      it "return status 404" do
        expect(response).to have_http_status(404)
      end
      
      it "returns a not found page" do
        expect(response.body).to match(/Couldn't find InvoiceStatusCode/)
      end
        
    end
  
  end

  describe "POST /invoice_status_codes" do
    let(:valid_attributes) {{description: 'Paid'}}

    context "when the request is valid" do
      before {post '/invoice_status_codes', params: valid_attributes}
      it "create a invoice_status_code" do
        expect(json['description']).to eq('Paid')
      end
      
      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
        
    
    end

    context "when the request is invalid" do
      before {post '/invoice_status_codes', params: {name: ''}}

      it "return a status code of 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a valid failure message" do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end

    end

  end

  describe "PUT /invoice_status_codes/:id" do
    let(:valid_attributes) {{description: 'Unpaid' }}
    context "when the record exists" do
      before {put "/invoice_status_codes/#{invoice_status_code_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to match(/InvoiceStatusCode Updated Successfully/) 
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /invoice_status_codes/:id' do
    before {delete "/invoice_status_codes/#{invoice_status_code_id}"}
    it "return status 200" do
      expect(response).to have_http_status(200)
    end
  end

end