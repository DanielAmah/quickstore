module Api
  module V1
    class OrderStatusCodesController < ApplicationController
      before_action :set_order_status_code, only: [:show, :update, :destroy]
      def index
        @order_status_codes = OrderStatusCode.all
        json_response(@order_status_codes)
      end

      def create
        @order_status_code = OrderStatusCode.create!(order_status_code_params)
        json_response(@order_status_code, :created)
      end

      def show
        json_response(@order_status_code)
      end

      def update
        @order_status_code.update(order_status_code_params)
        json_response({message: "OrderStatusCode Updated Successfully"})
      end

      def destroy
        @order_status_code.destroy
        json_response({message: "OrderStatusCode deleted Successfully"})
      end

      private

      def order_status_code_params
        params.permit(:description)
      end

      def set_order_status_code
        @order_status_code = OrderStatusCode.find(params[:id])
      end
    end
  end
end