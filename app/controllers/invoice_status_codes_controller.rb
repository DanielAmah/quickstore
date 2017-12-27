class InvoiceStatusCodesController < ApplicationController
  before_action :set_invoice_status_code, only: [:show, :update, :destroy]
  def index
    @invoice_status_codes = InvoiceStatusCode.all
    json_response(@invoice_status_codes)
  end

  def create
    @invoice_status_code = InvoiceStatusCode.create!(invoice_status_code_params)
    json_response(@invoice_status_code, :created)
  end

  def show
    json_response(@invoice_status_code)
  end

  def update
    @invoice_status_code.update(invoice_status_code_params)
    json_response({message: "InvoiceStatusCode Updated Successfully"})
  end

  def destroy
    @invoice_status_code.destroy
    json_response({message: "InvoiceStatusCode deleted Successfully"})
  end

  private

  def invoice_status_code_params
    params.permit(:description)
  end

  def set_invoice_status_code
    @invoice_status_code = InvoiceStatusCode.find(params[:id])
  end
end
