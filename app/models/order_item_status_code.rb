class OrderItemStatusCode < ApplicationRecord
  validates_presence_of :description
  has_many :order_items,  dependent: :destroy

  def self.get_order_item_status_codes
    all
  end

  def self.create_order_item_status_code(order_item_status_code_params)
    create!(order_item_status_code_params)
  end

  def self.find_order_item_status_code(params)
    find(params[:id])
  end
end
