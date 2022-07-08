class Room < ApplicationRecord
  belongs_to :user
  has_many :reserves
  validates :name, :introduction, :address, :room_image, presence: true
  validates :price, numericality: {only_integer: true}
  mount_uploader :room_image, ImageUploader

private
  def self.erea(search)
    Room.where("address LIKE?","%#{search}%")
  end
  def self.keyword(search)
    Room.where("(address LIKE?) OR (introduction LIKE?) OR (name LIKE?)",
    "%#{search}%","%#{search}%","%#{search}%")
  end
end

