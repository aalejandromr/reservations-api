require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "CRUD operations" do
    let!(:customer) { create(:customer) }
    let!(:agent) { create(:agent) }
    let!(:reservation) { create(:reservation) }
    let!(:vehicle_make) { Faker::Vehicle.fetch('vehicle.makes') }
    let!(:vehicle_model) { Faker::Vehicle.fetch("vehicle.models_by_make.#{vehicle_make}") }
    let!(:reservation_params) {{
      vehicle_make: vehicle_make,
      vehicle_model: vehicle_model,
      vehicle_year: '2024',
      reservation_time: Time.new('2024-02-28 08:00:00'),
      customer_email: customer.email,
      agent_code: agent.agent_code
    }}

    it 'should show a single reservation' do
      get "/api/v1/reservations/#{reservation.id}", params: { agent_code: agent.agent_code, format: :json }
      expect(response).to have_http_status(:ok)
    end

    it 'should throw unauthorized if an agent code is not passed' do
      get "/api/v1/reservations/#{reservation.id}"
      expect(response).to have_http_status(:unauthorized)
    end

    describe "Create reservation" do
      it 'should create a reservation' do
        expect {
          post '/api/v1/reservations', params: reservation_params
        }.to change{ Reservation.count }.by(1)
      end

      describe 'Valid parameters' do
        it 'should require a valid vehicle make' do
          post '/api/v1/reservations', params: reservation_params.merge(vehicle_make: 'Not Found')
          expect(response).to have_http_status(404)
        end

        it 'should require a valid vehicle model' do
          post '/api/v1/reservations', params: reservation_params.merge(vehicle_model: 'Not Found')
          expect(response).to have_http_status(404)
        end

        it 'should require a valid reservation time and reservation time must be within business hours' do
          # Business hours are 8 AM to 5 PM.
          # An invalid time will also be reservations starting at 5PM because each reservation is set to have a duration of 1 hour so the last spot available each day is 4 PM
          # Time format is YYYY-MM-DD HH:MM where hour is in 24 hours format
          post '/api/v1/reservations', params: reservation_params.merge(reservation_time: Time.new('2024-03-02'))
          expect(response).to have_http_status(400)

          post '/api/v1/reservations', params: reservation_params.merge(reservation_time: Time.new('2024-03-02 17:00:00'))
          expect(response).to have_http_status(400)
        end

        it 'should not create a reservation if an invalid customer is passed' do
          post '/api/v1/reservations', params: reservation_params.merge(customer_email: 'email_not_found@example.com')
          expect(response).to have_http_status(400)
        end

        it 'should not create a reservation if a reservation time is not available' do
          # First we do a valid reservation
          post '/api/v1/reservations', params: reservation_params
          expect(response).to have_http_status(200)
          # If another request is made with the same reservation time then it should fail
          post '/api/v1/reservations', params: reservation_params
          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
