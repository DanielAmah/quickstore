require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it {should belong_to(:order)}
  it {should belong_to(:invoice_status_code)}
  it {should validate_presence_of(:date)}
end
