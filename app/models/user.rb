class User < ApplicationRecord
  has_many :authentications, dependent: :destroy
  has_many :user_lessons, dependent: :destroy
  has_many :lessons, through: :user_lessons

  accepts_nested_attributes_for :authentications
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def to_param
    name
  end
end
