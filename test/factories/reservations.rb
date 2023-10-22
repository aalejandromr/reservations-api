FactoryBot.define do
  factory :reservation do
    vehicle_make { Faker::Vehicle.make }
    vehicle_model { Faker::Vehicle.model }
    vehicle_year { '2024' }
    reservation_time { Time.now }
    agent
    customer
  end
end