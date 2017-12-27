class Payment < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :date, :amount 
end
