class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :email, :avatar, :first_name, :last_name, :phone_number,
             :programming_skill, :date_of_birth, :profession, :user_type

  attribute :full_name do |object|
    "#{object.first_name} #{object.last_name}"
  end
end
