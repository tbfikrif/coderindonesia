class ScheduleSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :image, :form_link, :schedule_link,
             :learning_tools, :schedule_type, :status, :event_date

  belongs_to :mentor, serializer: :user
  belongs_to :category
end
