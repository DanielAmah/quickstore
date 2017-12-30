module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show, :update, :destroy]
      def index
        @categories = Category.all
        json_response(@categories)
      end

      def create
        @category = Category.create!(category_params)
        json_response(@category, :created)
      end

      def show
        json_response(@category)
      end

      def update
        @category.update(category_params)
        json_response({message: "Category Updated Successfully"})
      end

      def destroy
        @category.destroy
        json_response({message: "Category deleted Successfully"})
      end

      private

      def category_params
        params.permit(:id, :name, :description)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end