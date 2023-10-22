class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :vehicle_make
      t.string :vehicle_model
      t.references :agent, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :reservation_time

      t.timestamps
    end
  end
end
