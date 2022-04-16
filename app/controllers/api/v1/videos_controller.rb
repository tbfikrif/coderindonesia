module Api
  module V1
    class VideosController < ApiController
      before_action :authenticate_user!, except: %i[index]
      before_action :set_video, only: %i[show update destroy]
      load_and_authorize_resource

      def index
        videos = Video.all
        allowed = videos.attribute_names
        filtered = jsonapi_filter(videos, allowed)
        paginated = jsonapi_paginate(filtered.result)
        render jsonapi: paginated
      end

      def create
        video = Video.new(video_params)

        if video.save
          render jsonapi: video
        else
          render jsonapi_errors: video.errors, status: :unprocessable_entity
        end
      end

      def show
        render jsonapi: @video
      end

      def update
        if @video.update(video_params)
          render jsonapi: @video
        else
          render jsonapi_errors: @video.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @video.destroy
          render jsonapi: @video
        else
          render jsonapi_errors: @video.errors, status: :unprocessable_entity
        end
      end

      private

      def set_video
        @video = Video.find(params[:id])
      end

      def video_params
        params.require(:video)
              .permit(
                :title, :description, :image, :video_link, :video_type, :mentor_id, :category_id
              )
      end
    end
  end
end
