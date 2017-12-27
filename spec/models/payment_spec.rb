require 'rails_helper'

RSpec.describe Payment, type: :model do
  it {should belong_to(:invoice)}
  it {should validate_presence_of(:date)}
  it {should validate_presence_of(:amount)}
end
