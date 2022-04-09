module Api
  module V1
    class ArticlesController < ApiController
      before_action :authenticate_user!
      before_action :set_article, only: %i[show update destroy]
      load_and_authorize_resource

      def index
        articles = Article.all
        allowed = articles.attribute_names
        filtered = jsonapi_filter(articles, allowed)
        paginated = jsonapi_paginate(filtered.result)
        render jsonapi: paginated
      end

      def create
        article = Article.new(article_params)

        if article.save
          render jsonapi: article
        else
          render jsonapi_errors: article.errors, status: :unprocessable_entity
        end
      end

      def show
        render jsonapi: @article
      end

      def update
        if @article.update(article_params)
          render jsonapi: @article
        else
          render jsonapi_errors: @article.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @article.destroy
          render jsonapi: @article
        else
          render jsonapi_errors: @article.errors, status: :unprocessable_entity
        end
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article)
              .permit(
                :title, :description, :image, :author_id, :category_id
              )
      end
    end
  end
end
