class AddUserReferenceToPaymentMethods < ActiveRecord::Migration[5.0]
  def change
    add_reference :payment_methods, :user, foreign_key: true
  end
end
