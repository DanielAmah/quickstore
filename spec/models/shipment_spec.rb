require 'rails_helper'

RSpec.describe Shipment, type: :model do
  it {should belong_to(:order)}
  it {should belong_to(:invoice)}
  it {should validate_presence_of(:tracking_number)}
  it {should validate_presence_of(:date)}
end
