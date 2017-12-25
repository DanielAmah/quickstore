class OrderStatusCode < ApplicationRecord
  has_many :orders,  dependent: :destroy

  validates_presence_of :description
end
