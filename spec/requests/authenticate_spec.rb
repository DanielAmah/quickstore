require 'rails_helper'

RSpec.describe 'Authenticate API', type: :request do
  let!(:roles) { create_list(:role, 4) }
  let!(:users) { create_list(:user, 4, role_id: roles.first.id) }
  let(:role_id) { roles.first.id }
  let!(:user_id) { users.first.id }

describe 'POST /register' do
  # valid payload
   let(:valid_attributes) { { name: 'daniel', email: 'jack@test.com', password: 'mealso', phone_number: '08012345678', address: 'No 22 MaryLand', city: 'lagos', state: 'lagos', country: 'Nigeria', role_id: roles.first.id  }}

   context 'when the request is valid' do
     before do
       post '/auth/register', params: valid_attributes
     end

     it 'creates a user' do
       expect(json['name']).to eq('daniel')
     end

     it 'returns status code 201' do
       expect(response).to have_http_status(201)
     end
   end

   context 'when the request is invalid' do
     before do
       post '/auth/register', params: { key: 'fake', email: 'jack@gmail.com', password: 'fake' }
     end

     it 'returns status code 422' do
       expect(response).to have_http_status(422)
     end

     it 'returns a validation failure message' do
       expect(response.body)
         .to match(/Validation failed: Name can't be blank/)
     end
   end
 end
end
