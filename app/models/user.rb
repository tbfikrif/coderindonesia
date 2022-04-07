class User < ApplicationRecord
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  mount_uploader :avatar, AvatarUploader

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  validates :first_name, :phone_number, presence: true

  enumerize :programming_skill, in: { beginner: 1, intermediate: 2, advanced: 3, professional: 4, expert: 5 }
  enumerize :user_type, in: { starter: 1, basic: 2, pro: 3 }, default: :starter

  attr_reader :token

  def on_jwt_dispatch(token, _payload)
    @token = token
  end
end
