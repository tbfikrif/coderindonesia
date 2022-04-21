module Api
  module V1
    class SchedulesController < ApiController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_schedule, only: %i[show update destroy]
      load_and_authorize_resource

      def index
        schedules = Schedule.all
        allowed = schedules.attribute_names
        filtered = jsonapi_filter(schedules, allowed)
        paginated = jsonapi_paginate(filtered.result)
        render jsonapi: paginated
      end

      def create
        schedule = Schedule.new(schedule_params)

        if schedule.save
          render jsonapi: schedule
        else
          render jsonapi_errors: schedule.errors, status: :unprocessable_entity
        end
      end

      def show
        render jsonapi: @schedule
      end

      def update
        if @schedule.update(schedule_params)
          render jsonapi: @schedule
        else
          render jsonapi_errors: @schedule.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @schedule.destroy
          render jsonapi: @schedule
        else
          render jsonapi_errors: @schedule.errors, status: :unprocessable_entity
        end
      end

      private

      def set_schedule
        @schedule = Schedule.find(params[:id])
      end

      def schedule_params
        params.require(:schedule)
              .permit(
                :title, :description, :image, :form_link, :schedule_link, :schedule_type,
                :status, :event_date, :mentor_id, :category_id, learning_tools: []
              )
      end
    end
  end
end
