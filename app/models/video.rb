class Video < ApplicationRecord
  resourcify
  extend Enumerize

  belongs_to :mentor, class_name: 'User'
  belongs_to :category

  mount_uploader :image, ImageUploader

  validates :title, :description, :video_link, :video_type, presence: true

  enumerize :video_type, in: { free: 1, premium: 2 }, default: :free
end
