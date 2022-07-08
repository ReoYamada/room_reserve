class User < ApplicationRecord
  validates :password, confirmation: true, on: :password_change
  validates :password_confirmation, presence: true, on: :password_change
  validates :name, :email, presence: true
  has_secure_password
  mount_uploader :user_image, ImageUploader
  has_many :posts, dependent: :destroy
  has_many :reserves
end
