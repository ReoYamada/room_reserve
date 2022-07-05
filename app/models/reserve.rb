class Reserve < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :start_day, :end_day, :number_of_people, presence: true
end
