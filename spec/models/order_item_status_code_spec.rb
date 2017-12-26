require 'rails_helper'

RSpec.describe OrderItemStatusCode, type: :model do
  it {should validate_presence_of(:description)}
end
