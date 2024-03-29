Trestle.resource(:users, model: User, scope: Auth) do
  menu do
    group :configuration, priority: :first do
      item :users, icon: "fas fa-users"
    end
  end

  table do
    column :avatar, class: "poster-column" do |user|
      admin_link_to(image_tag(user.avatar_url(:thumb), class: "poster"), user) if user.avatar.present?
    end
    column :email, link: true
    column :first_name
    column :last_name
    column :roles, format: :tags, class: "hidden-xs" do |user|
      user.roles.map(&:name)
    end
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |user|
    text_field :email
    text_field :username
    file_field :avatar
    text_field :phone_number
    select :role_ids, Role.all, { label: "Role" }

    row do 
      col(sm: 6) { text_field :first_name }
      col(sm: 6) { text_field :last_name }
    end

    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
  end

  # Ignore the password parameters if they are blank
  update_instance do |instance, attrs|
    if attrs[:password].blank?
      attrs.delete(:password)
      attrs.delete(:password_confirmation) if attrs[:password_confirmation].blank?
    end

    instance.assign_attributes(attrs)
  end

  # Log the current user back in if their password was changed
  after_action on: :update do
    if instance == current_user && instance.encrypted_password_previously_changed?
      login!(instance)
    end
  end if Devise.sign_in_after_reset_password
end
