class Article < ApplicationRecord
  resourcify

  belongs_to :author, class_name: 'User'
  belongs_to :category

  mount_uploader :image, ImageUploader

  validates :title, :description, presence: true
end
