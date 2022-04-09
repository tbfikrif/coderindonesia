class ArticleSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :image

  belongs_to :author, serializer: :user
  belongs_to :category
end
