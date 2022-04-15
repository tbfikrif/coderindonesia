Trestle.resource(:categories) do
  menu do
    group :configuration do
      item :categories, icon: 'fa fa-list'
    end
  end

  table do
    column :id
    column :name
    column :description
    actions
  end

  form dialog: true do |category|
    text_field :name
    text_field :description
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:category).permit(:name, ...)
  # end
end
