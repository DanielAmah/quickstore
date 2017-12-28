class PaymentMethodsController < ApplicationController
  before_action :set_payment_method, only: [:show, :update, :destroy]
  def index
    @payment_methods = PaymentMethod.all
    json_response(@payment_methods)
  end

  def create
    @payment_method = PaymentMethod.create!(payment_method_params)
    json_response(@payment_method, :created)
  end

  def show
    json_response(@payment_method)
  end

  def update
    @payment_method.update(payment_method_params)
    json_response({message: "PaymentMethod Updated Successfully"})
  end

  def destroy
    @payment_method.destroy
    json_response({message: "PaymentMethod deleted Successfully"})
  end

  private

  def payment_method_params
    params.permit(:description)
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end
end
