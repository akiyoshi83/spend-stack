module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_api
      before_action :set_category, only: [:update, :destroy]

      def index
        @categories = current_user.categories || []
        render
      end

      def create
        @category = current_user.categories.build(category_params)
        @category.save
        render status: :created
      end

      def update
        @category.update!(category_params)
        head :no_content
      end

      def destroy
        @category.destroy
        head :no_content
      end

      private

      def category_params
        params.require(:category).permit(:name, :color, :user_id)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
