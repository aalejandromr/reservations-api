class Reservation < ApplicationRecord
  belongs_to :agent
  belongs_to :customer

  validates :vehicle_make, :vehicle_model, :reservation_time, :vehicle_year, presence: true
end
