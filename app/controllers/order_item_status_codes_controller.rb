class OrderItemStatusCodesController < ApplicationController
  before_action :set_order_item_status_code, only: [:show, :update, :destroy]
  def index
    @order_item_status_codes = OrderItemStatusCode.all
    json_response(@order_item_status_codes)
  end

  def create
    @order_item_status_code = OrderItemStatusCode.create!(order_item_status_code_params)
    json_response(@order_item_status_code, :created)
  end

  def show
    json_response(@order_item_status_code)
  end

  def update
    @order_item_status_code.update(order_item_status_code_params)
    json_response({message: "OrderItemStatusCode Updated Successfully"})
  end

  def destroy
    @order_item_status_code.destroy
    json_response({message: "OrderItemStatusCode deleted Successfully"})
  end

  private

  def order_item_status_code_params
    params.permit(:description)
  end

  def set_order_item_status_code
    @order_item_status_code = OrderItemStatusCode.find(params[:id])
  end
end
