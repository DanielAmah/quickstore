module Api
  module V1
      class OrdersController < ApplicationController
        before_action :set_order_status_code
        before_action :set_order, only: [:show, :update, :destroy]

        def index
          json_response(@order_status_code.orders)
        end

        def show
          json_response(@order)
        end

        def create
        @order_status_code.orders.create!(order_params)
        json_response(@order_status_code, :created)
        end

        def update
          @order.update(order_params)
          json_response({message: "Order Updated Successfully"})
        end

        def destroy
          @order.destroy
          json_response({message: "Order deleted Successfully"}) 
        end

        private

        def order_params
          params.permit(:date, :description, :order_status_code_id)
        end

        def set_order_status_code
          @order_status_code = OrderStatusCode.find(params[:order_status_code_id])
        end

        def set_order
          @order = @order_status_code.orders.find_by!(id: params[:id]) if @order_status_code
        end
      end
    end
  end