Trestle.resource(:schedules) do
  menu do
    item :schedules, icon: "fa fa-clock"
  end

  table do
    column :id
    column :image, class: "poster-column" do |schedule|
      admin_link_to(image_tag(schedule.image_url(:thumb), class: "poster"), schedule) if schedule.image.present?
    end
    column :title
    column :description
    column :form_link
    column :schedule_link
    column :schedule_type
    column :event_date
    column :status
    column :learning_tools, format: :tags, class: "hidden-xs" do |schedule|
      schedule.learning_tools
    end
    column :mentor
    column :category
    actions
  end

  form do |schedule|
    text_field :title
    editor :description
    file_field :image
    date_field :event_date
    select :learning_tools, TOOLS, { label: "Tools" }, multiple: true

    row do
      col(sm: 6) { text_field :form_link }
      col(sm: 6) { text_field :schedule_link }
    end

    row do
      col(sm: 6) { select :schedule_type, Schedule.schedule_type.values, { label: "Type" } }
      col(sm: 6) { select :status, Schedule.status.values, { label: "Status" } }
    end

    row do
      col(sm: 6) { select :mentor_id, User.with_any_role(:admin, :mentor) }
      col(sm: 6) { select :category_id, Category.all }
    end
  end
end
