class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
    def index
        @products = Product.all
        json_response(@products)
    end

    def create
        @product = Product.create!(product_params)
        json_response(@product, :created)
    end

    def show
        json_response(@product)
    end

    def update
        @product.update(product_params)
        json_response({message: "Product Updated Successfully"})
    end

    def destroy
        @product.destroy
        json_response({message: "Product deleted Successfully"})
        
    end

    private

    def product_params
        params.permit(:id, :name, :price, :color, :size, :description)
    end

    def set_product
        @product = Product.find(params[:id])
    end
end
