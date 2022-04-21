class Schedule < ApplicationRecord
  resourcify
  extend Enumerize

  belongs_to :mentor, class_name: 'User'
  belongs_to :category

  mount_uploader :image, ImageUploader

  validates :title, :description, :form_link, :schedule_link, :event_date, :schedule_type, :status, presence: true

  enumerize :schedule_type, in: { workshop: 1, seminar: 2, academy: 3 }, default: :workshop
  enumerize :status, in: { coming: 1, ongoing: 2, finish: 3 }, default: :coming

  def learning_tools=(value)
    case value
    when Array
      super(value.reject(&:empty?))
    else
      super
    end
  end
end
