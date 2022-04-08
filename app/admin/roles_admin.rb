Trestle.resource(:roles) do
  menu do
    group :configuration, priority: :last do
      item :roles, icon: "fas fa-flag"
    end
  end

  table do
    column :id
    column :name
    actions
  end

  form dialog: true do |role|
    text_field :name
  end
end
