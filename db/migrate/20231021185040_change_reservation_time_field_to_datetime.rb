class ChangeReservationTimeFieldToDatetime < ActiveRecord::Migration[7.0]
  def change
    change_column :reservations, :reservation_time, :datetime, null: false
  end
end
