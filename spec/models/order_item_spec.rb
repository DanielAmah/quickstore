require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it {should belong_to(:order)}
  it {should belong_to(:product)}
  it {should belong_to(:order_item_status_code)}
  it {should validate_presence_of(:quantity)}
  it {should validate_presence_of(:price)}
end
