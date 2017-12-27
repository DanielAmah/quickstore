class ShipmentsController < ApplicationController
  before_action :set_order
  before_action :set_shipment, only: [:show, :update, :destroy]

  def index
    json_response(@order.shipments)
  end

  def show
    json_response(@shipment)
  end

  def create
  @order.shipments.create!(shipment_params)
  json_response(@order, :created)
  end

  def update
    @shipment.update(shipment_params)
    json_response({message: "Shipment Updated Successfully"})
  end

  def destroy
    @shipment.destroy
    json_response({message: "Shipment deleted Successfully"}) 
  end

  private

  def shipment_params
    params.permit(:tracking_number, :date, :description, :order_id, :invoice_id)
  end

  def set_order_status_code
    @order_status_code = OrderStatusCode.find(params[:order_status_code_id])
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def set_shipment
    @shipment = @order.shipments.find_by!(id: params[:id]) if @order
  end
end
