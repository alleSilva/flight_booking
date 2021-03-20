defmodule FlightBooking do
  alias FlightBooking.Users.Agent, as: UserAgent
  alias FlightBooking.Users.CreateOrUpdate, as: CreateUpdateUser
  alias FlightBooking.Bookings.Agent, as: BookingAgent
  alias FlightBooking.Bookings.CreateOrUpdate, as: CreateUpdateBooking 

  def init_user_agent do
    UserAgent.start_link(%{})
  end

  def init_booking_agent do
    BookingAgent.start_link(%{})                             end

  def get_user(id), do: UserAgent.get(id)

  def get_booking(id), do: BookingAgent.get(id)

  defdelegate create_user(params), to: CreateUpdateUser, as: :call

  defdelegate create_booking(params), to: CreateUpdateBooking, as: :call
end
