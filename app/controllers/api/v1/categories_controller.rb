module Api
  module V1
    class CategoriesController < ApiController
      before_action :authenticate_user!
      before_action :set_category, only: %i[show update destroy]

      def index
        category = Category.all
        category_serializer = CategorySerializer.new(category)
        render json: { count: category.count, data: category_serializer }
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: {
            success: true,
            messages: 'Berhasil menambahkan data'
          }
        else
          render json: {
            success: false,
            messages: 'Gagal menambahkan data',
            error: category.errors.full_messages
          }
        end
      end

      def show
        render json: @category, serializer: CategorySerializer
      end

      def update
        if @category.update(category_params)
          render json: {
            success: true,
            messages: 'Berhasil mengubah data'
          }
        else
          render json: {
            success: false,
            messages: 'Gagal mengubah data',
            error: @category.errors.full_messages
          }
        end
      end

      def destroy
        if @category.destroy
          render json: {
            success: true,
            messages: 'Berhasil menghapus data'
          }
        else
          render json: {
            success: false,
            messages: 'Gagal menghapus data',
            error: @category.errors.full_messages
          }
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
