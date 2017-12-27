require 'rails_helper'

RSpec.describe InvoiceStatusCode, type: :model do
  it {should validate_presence_of(:description)}
end
