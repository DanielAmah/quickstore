class Product < ApplicationRecord
    validates_presence_of :name, :price, :description
    belongs_to :category
    has_many :order_items,  dependent: :destroy
end
