module Api::V1
  class ReservationsController < ApplicationController
    include ExceptionHandler
    
    attr_reader :customer, :reservation

    before_action :set_reservation, except: %i[create]
    before_action :set_customer, only: %i[create]

    def create
      reservation = GenerateReservationService.new(reservation_params, agent: agent, customer: customer).call
      render json: serializable(reservation)
    end

    def show
      render json: serializable(reservation)
    end

    private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.permit(
        reservation_time: Parameters.time.required, 
        vehicle_make: Parameters.string.required, 
        vehicle_model: Parameters.string.required, 
        vehicle_year: Parameters.string.required
      )
    end

    def customer_params
      params.permit(
        customer_email: Parameters.string.required
      )
    end

    def set_customer
      @customer = Customer.find_by(email: customer_params[:customer_email])
    end

    def serializable(reservation)
      ReservationSerializer.new(reservation).serializable_hash
    end
  end
end