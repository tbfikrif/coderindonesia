Trestle.resource(:articles) do
  menu do
    item :articles, icon: "fa fa-book"
  end

  table do
    column :id
    column :image, class: "poster-column" do |user|
      admin_link_to(image_tag(user.image_url(:thumb), class: "poster"), user) if user.image.present?
    end
    column :title
    column :description
    column :author
    column :category
    actions
  end

  form do |article|
    text_field :title
    editor :description
    file_field :image

    row do
      col(sm: 6) { select :author_id, User.all }
      col(sm: 6) { select :category_id, Category.all }
    end
  end
end
