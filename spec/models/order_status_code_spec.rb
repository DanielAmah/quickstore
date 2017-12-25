require 'rails_helper'

RSpec.describe OrderStatusCode, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it {should validate_presence_of(:description)}
end
