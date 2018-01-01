module Api
  module V1
    class ShipmentItemsController < ApplicationController
      before_action :set_order_item
      before_action :set_shipment_item, only: [:show, :update, :destroy]

      def index
        json_response(@order_item.shipment_items)
      end

      def show
        json_response(@shipment_items)
      end

      def create
      @order_item.shipment_items.create!(shipment_item_params)
      json_response(@order_item, :created)
      end

      def update
        @shipment_item.update(shipment_item_params)
        json_response({message: "ShipmentItem Updated Successfully"})
      end

      def destroy
        @shipment_item.destroy
        json_response({message: "ShipmentItem deleted Successfully"}) 
      end

      private

      def shipment_item_params
        params.permit(:shipment_id, :order_item_id)
      end

      def set_order_status_code
        @order_status_code = OrderStatusCode.find(params[:order_status_code_id])
      end

      def set_order
        @order = Order.find(params[:order_id])
      end

      def set_order_item
        @order_item = OrderItem.find(params[:order_item_id])
      end

      def set_shipment_item
        @shipment_item = @order_item.shipment_items.find_by!(id: params[:id]) if @order_item
      end
    end
  end
end