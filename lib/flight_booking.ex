defmodule FlightBooking do
  alias FlightBooking.Bookings.Agent, as: BookingAgent
  alias FlightBooking.Bookings.CreateOrUpdate, as: CreateUpdateBooking
  alias FlightBooking.Bookings.Report, as: BookingsReport
  alias FlightBooking.Users.Agent, as: UserAgent
  alias FlightBooking.Users.CreateOrUpdate, as: CreateUpdateUser

  def start_agents() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  def get_user(id), do: UserAgent.get(id)

  def get_booking(id), do: BookingAgent.get(id)

  defdelegate create_user(params), to: CreateUpdateUser, as: :call

  defdelegate create_booking(params), to: CreateUpdateBooking, as: :call
  defdelegate report_by_date(from, to), to: BookingsReport, as: :report_by_date
end
