require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'creation' do
    let!(:vehicle_make) { Faker::Vehicle.fetch('vehicle.makes') }
    let!(:vehicle_model) { Faker::Vehicle.fetch("vehicle.models_by_make.#{vehicle_make}") }
    let!(:customer) { create(:customer) }
    let!(:agent) { create(:agent) }
    let!(:vehicle_year) { '2024' }
    
    it "should save if all required field are passed" do
      reservation = Reservation.new(
        vehicle_make: vehicle_make,
        vehicle_model: vehicle_model,
        vehicle_year: vehicle_year,
        reservation_time: Time.now,
        customer: customer,
        agent: agent
      )

      expect(reservation.save!).to eq(true)
    end

    it "should not save reservation if vehicle make is missing" do
      reservation = Reservation.new(
        vehicle_model: vehicle_model,
        vehicle_year: vehicle_year,
        customer: customer,
        agent: agent
      )

      expect { reservation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save reservation if vehicle model is missing" do
      reservation = Reservation.new(
        vehicle_make: vehicle_make,
        vehicle_year: vehicle_year,
        customer: customer,
        agent: agent
      )

      expect { reservation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save reservation if vehicle year is missing" do
      reservation = Reservation.new(
        vehicle_make: vehicle_make,
        vehicle_model: vehicle_model,
        customer: customer,
        agent: agent
      )

      expect { reservation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save reservation if vehicle customer is missing" do
      reservation = Reservation.new(
        vehicle_make: vehicle_make,
        vehicle_model: vehicle_model,
        vehicle_year: vehicle_year,
        agent: agent
      )

      expect { reservation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save reservation if vehicle agent is missing" do
      reservation = Reservation.new(
        vehicle_make: vehicle_make,
        vehicle_model: vehicle_model,
        vehicle_year: vehicle_year,
        customer: customer
      )

      expect { reservation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
