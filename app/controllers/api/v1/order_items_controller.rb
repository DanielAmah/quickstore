module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :set_product
      before_action :set_order_item, only: [:show, :update, :destroy]

      def index
        json_response(@product.order_items)
      end

      def show
        json_response(@order_item)
      end

      def create
      @product.order_items.create!(order_item_params)
      json_response(@product, :created)
      end

      def update
        @order_item.update(order_item_params)
        json_response({message: "OrderItem Updated Successfully"})
      end

      def destroy
        @order_item.destroy
        json_response({message: "OrderItem deleted Successfully"}) 
      end

      private

      def order_item_params
        params.permit(:quantity, :price, :RMA_number, :RMA_issue_by, :RMA_issued_date, :description, :product_id, :order_id, :order_item_status_code_id)
      end

      def set_product
        @product = Product.find(params[:product_id])
      end

      def set_order
        @order = Order.find(params[:order_id])
      end

      def set_order_item_status_code
        @order_item_status_code = OrderItemStatusCode.find(params[:order_item_status_code_id])
      end

      def set_order_item
        @order_item = @product.order_items.find_by!(id: params[:id]) if @product 
      end
    end
  end
end
