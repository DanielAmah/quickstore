require 'rails_helper'

RSpec.describe ShipmentItem, type: :model do
  it {should belong_to(:shipment)}
  it {should belong_to(:order_item)}
end
