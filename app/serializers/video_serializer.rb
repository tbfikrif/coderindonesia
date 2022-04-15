class VideoSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :image, :video_link, :video_type

  belongs_to :mentor, serializer: :user
  belongs_to :category
end
