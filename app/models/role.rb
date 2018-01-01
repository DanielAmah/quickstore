class Role < ApplicationRecord
  validates_presence_of :role
  has_many :users,  dependent: :destroy
end
