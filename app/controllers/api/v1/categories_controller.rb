module Api
  module V1
    class CategoriesController < ApiController
      before_action :authenticate_user!
      before_action :set_category, only: %i[show update destroy]
      load_and_authorize_resource

      def index
        categories = Category.all
        allowed = categories.attribute_names
        filtered = jsonapi_filter(categories, allowed)
        paginated = jsonapi_paginate(filtered.result)
        render jsonapi: paginated
      end

      def create
        category = Category.new(category_params)

        if category.save
          render jsonapi: category
        else
          render jsonapi_errors: category.errors, status: :unprocessable_entity
        end
      end

      def show
        render jsonapi: @category
      end

      def update
        if @category.update(category_params)
          render jsonapi: @category
        else
          render jsonapi_errors: @category.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          render jsonapi: @category
        else
          render jsonapi_errors: @category.errors, status: :unprocessable_entity
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category)
              .permit(
                :name, :description
              )
      end
    end
  end
end
