class User < ApplicationRecord
  #Validations
  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true
  belongs_to :role

  #encrypt password
  has_secure_password

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
    where("email LIKE ?", "%#{search}%")
  end
end
