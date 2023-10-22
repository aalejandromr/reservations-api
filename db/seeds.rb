class Seeder

  SEED_MODELS = [Reservation, Agent, Customer]
  AGENT_CODES = [28392, 29302]

  def call
    raise 'Seeder cannot be run in production' if Rails.env.production?
    clear_seed_tables
    populate_seed_tables
  end

  private

  def clear_seed_tables
    SEED_MODELS.each(&:delete_all)
  end

  def populate_seed_tables
    seed_customers
    seed_agents
    seed_reservations
  end

  def seed_customers
    Customer.create!(
      email: 'customer@example.com',
      phone_number: Faker::PhoneNumber.cell_phone
    )
  end

  def seed_agents
    Array.new(2).each_with_index { |_, key|
      Agent.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        agent_code: AGENT_CODES[key]
      )
    }
  end

  def seed_reservations
    vehile_make = Faker::Vehicle.fetch('vehicle.makes')
    Reservation.create!(
      vehicle_make: vehile_make,
      vehicle_model: Faker::Vehicle.fetch("vehicle.models_by_make.#{vehile_make}"),
      vehicle_year: Faker::Vehicle.year,
      agent: Agent.first,
      customer: Customer.first,
      reservation_time: DateTime.now
    )
  end
end

Seeder.new.call