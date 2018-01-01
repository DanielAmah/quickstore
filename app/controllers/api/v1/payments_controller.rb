module Api
  module V1
class PaymentsController < ApplicationController
  before_action :set_invoice
  before_action :set_payment, only: [:show, :update, :destroy]

  def index
    json_response(@invoice.payments)
  end

  def show
    json_response(@payment)
  end

  def create
  @invoice.payments.create!(payment_params)
  json_response(@invoice, :created)
  end

  def update
    @payment.update(payment_params)
    json_response({message: "Payment Updated Successfully"})
  end

  def destroy
    @payment.destroy
    json_response({message: "Payment deleted Successfully"}) 
  end

  private

  def payment_params
    params.permit(:date, :amount, :invoice_id)
  end

  def set_order_status_code
    @order_status_code = OrderStatusCode.find(params[:order_status_code_id])
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_invoice_status_code
    @invoice_status_code = InvoiceStatusCode.find(params[:invoice_status_code_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def set_payment
    @payment = @invoice.payments.find_by!(id: params[:id]) if @invoice
  end
end
end
end