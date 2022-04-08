module Api
  module V1
    class CategoriesController < ApiController
      before_action :authenticate_user!
      before_action :set_category, only: %i[show update destroy]
      load_and_authorize_resource

      def index
        category = Category.all
        category_serializer = CategorySerializer.new(category)
        render json: { count: category.count, data: category_serializer }
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: {
            messages: I18n.t('activerecord.success.messages.create', model: category.model_name.human)
          }, status: :ok
        else
          render json: {
            messages: I18n.t('activerecord.errors.messages.create', model: category.model_name.human),
            error: category.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def show
        render json: @category, serializer: CategorySerializer
      end

      def update
        if @category.update(category_params)
          render json: {
            messages: I18n.t('activerecord.success.messages.update', model: @category.model_name.human)
          }, status: :ok
        else
          render json: {
            messages: I18n.t('activerecord.errors.messages.update', model: @category.model_name.human),
            error: @category.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          render json: {
            messages: I18n.t('activerecord.success.messages.destroy', model: @category.model_name.human)
          }, status: :ok
        else
          render json: {
            messages: I18n.t('activerecord.errors.messages.destroy', model: @category.model_name.human),
            error: @category.errors.full_messages
          }, status: :unprocessable_entity
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
