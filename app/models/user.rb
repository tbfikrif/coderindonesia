class User < ApplicationRecord
  rolify before_add: :delete_previous_role
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist, authentication_keys: [:login]

  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  validates :first_name, :phone_number, presence: true

  enumerize :programming_skill, in: { beginner: 1, intermediate: 2, advanced: 3, professional: 4, expert: 5 }
  enumerize :user_type, in: { starter: 1, basic: 2, pro: 3 }, default: :starter

  attr_reader :token
  attr_writer :login

  after_create :assign_default_role

  def on_jwt_dispatch(token, _payload)
    @token = token
  end

  def initials
    first_name[0, 1]
  end

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h)
        .where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
        .first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  def author?
    has_role?(:author)
  end

  def mentor?
    has_role?(:mentor)
  end

  def user_pro?
    user_type == 'pro'
  end

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def delete_previous_role(assigned_role)
    return if roles.pluck(:name).include?(assigned_role.name)

    roles.delete(roles.where(id: roles.ids))
  end
end
