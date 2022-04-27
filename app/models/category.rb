class Category < ApplicationRecord
  has_many :articles
  has_many :videos
  has_many :schedules

  validates :name, :description, presence: true
end
