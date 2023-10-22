# The purpose of this service is to handle every business decision before creating the service
class GenerateReservationService
  attr_accessor :params, :agent, :customer, :reservation_time

  BUSINESS_HOUR_OPEN = 8
  BUSINESS_HOUR_CLOSE = 16

  def initialize(params, agent:, customer:)
    @params = params
    @agent = agent
    @customer = customer
    @reservation_time = params[:reservation_time]
  end

  def call
    # First, we need to check if the reservation is within the business hours, if the reservation time is free meaning that a reservation is not going from the time the reservation starts
    # We also need to make sure we give service to the model and make requested.
    reservation_time_within_business_hours!
    reservation_time_free!
    vehicle_make_and_model_not_supported!
    Reservation.create!(reservation_params) 
  end

  private

  def reservation_time_within_business_hours!
    raise ExceptionHandler::IncorrectReservationTime unless (BUSINESS_HOUR_OPEN..BUSINESS_HOUR_CLOSE).include? reservation_time.hour
  end

  def reservation_time_free!
    # Reservation duration default is 1 hour, so we need to check whether there are existing reservation spots
    # in or during the reservation time requested.
    # Example: Resevation at 1:00 PM is set to last until 2:00 PM. Request is for 1:30 PM, there is not an available spot since there is a reservation between 1:00 PM and 2:00 PM.
    raise ExceptionHandler::ReservationTimeNotAvailable if Reservation.where(reservation_time: reservation_time..reservation_time + 1.hour).exists?
  end

  def reservation_params
    params.merge(
      agent: agent,
      customer: customer
    )
  end

  def vehicle_make_and_model_not_supported!
    begin
      # If we do not suppor the requested make and mode raise an exception
      models_by_vehicle_make_available = Faker::Vehicle.fetch_all("vehicle.models_by_make.#{params[:vehicle_make]}")
      raise 'Model not found' unless models_by_vehicle_make_available.include? params[:vehicle_model]
    rescue => e
      raise ExceptionHandler::MakeOrModelNotSupported
    end
  end
end