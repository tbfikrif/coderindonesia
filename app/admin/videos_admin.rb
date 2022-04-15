Trestle.resource(:videos) do
  menu do
    item :videos, icon: "fa fa-film"
  end

  table do
    column :id
    column :image, class: "poster-column" do |video|
      admin_link_to(image_tag(video.image_url(:thumb), class: "poster"), video) if video.image.present?
    end
    column :title
    column :description
    column :video_link
    column :video_type
    column :mentor
    column :category
    actions
  end

  form do |video|
    text_field :title
    editor :description
    file_field :image
    text_field :video_link
    select :video_type, Video.video_type.values, { label: "Type" }

    row do
      col(sm: 6) { select :mentor_id, User.with_any_role(:admin, :mentor) }
      col(sm: 6) { select :category_id, Category.all }
    end
  end
end
