# The purpose of this calss is the capture the exceptions created across the app and respond with an appropiate json describing the errors
module ExceptionHandler
  extend ActiveSupport::Concern

  class MakeOrModelNotSupported < StandardError; end
  class ReservationTimeNotAvailable < StandardError; end
  class IncorrectReservationTime < StandardError; end

  included do
    rescue_from MakeOrModelNotSupported, with: :make_or_model_not_found
    rescue_from ReservationTimeNotAvailable, with: :reservation_not_available
    rescue_from IncorrectReservationTime, with: :reservation_time_format_error
    rescue_from ActiveRecord::RecordInvalid, with: :record_must_exists
  end

  def make_or_model_not_found
    return render json: {
      error: 'Make or model not supported'
    }, status: 404
  end

  def reservation_not_available
    return render json: {
      error: 'Reservation time is not available'
    }, status: 400
  end
  
  def reservation_time_format_error
    return render json: {
      error: 'Reservation time must be of the format YYYY-MM-DD HH:MM and the hour of the reservation must be between 8AM to 4PM UTC'
    }, status: 400
  end

  def record_must_exists
    return render json: {
      error: 'Please check your request, a record that should exist doesn\'t'
    }, status: 400
  end
end