module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :set_order
      before_action :set_invoice, only: [:show, :update, :destroy]

      def index
        json_response(@order.invoices)
      end

      def show
        json_response(@invoice)
      end

      def create
      @order.invoices.create!(invoice_params)
      json_response(@order, :created)
      end

      def update
        @invoice.update(invoice_params)
        json_response({message: "Invoice Updated Successfully"})
      end

      def destroy
        @invoice.destroy
        json_response({message: "Invoice deleted Successfully"}) 
      end

      private

      def invoice_params
        params.permit(:date, :description, :order_id, :invoice_status_code_id)
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
        @invoice = @order.invoices.find_by!(id: params[:id]) if @order 
      end
    end
  end
end