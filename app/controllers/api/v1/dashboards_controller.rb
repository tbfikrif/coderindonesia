module Api
  module V1
    class DashboardsController < ApiController
      before_action :authenticate_user!, except: %i[list]

      def list
        render json: {
          category: CategorySerializer.new(Category.order(created_at: :asc)).serializable_hash,
          article: ArticleSerializer.new(Article.order(created_at: :asc).limit(3)).serializable_hash,
          video: VideoSerializer.new(Video.order(created_at: :asc).limit(3)).serializable_hash,
          schedule: ScheduleSerializer.new(Schedule.order(created_at: :asc).limit(3)).serializable_hash
        }
      end
    end
  end
end
