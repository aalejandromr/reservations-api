class ReservationSerializer
  include JSONAPI::Serializer
  attributes :reservation_time, 
             :vehicle_make, 
             :vehicle_model, 
             :vehicle_year
  
  attributes :customer_email do |reservation|
    reservation.customer.email
  end

  attributes :agent_full_name do |reservation|
    "#{reservation.agent.full_name}"
  end

  belongs_to :customer
  belongs_to :agent
end
