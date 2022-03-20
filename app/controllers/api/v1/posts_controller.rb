class Api::V1::PostsController < ApiController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  def index
    post = Post.all
    post_serializer = PostSerializer.new(post)
    render json: { count: post.count, data: post_serializer }
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post)
          .permit(
            :title, :content
          )
  end
end
