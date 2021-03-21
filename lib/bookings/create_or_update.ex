defmodule FlightBooking.Bookings.CreateOrUpdate do
  alias FlightBooking.Bookings.Agent, as: BookingAgent
  alias FlightBooking.Bookings.Booking

  def call(%{
    complete_date: complete_date,
    from_city: from_city,
    to_city: to_city, user: user}) do
    complete_date
    |> Booking.build(from_city, to_city, user)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{id: id} = booking}) do
    case BookingAgent.save(booking) do
      :ok -> {:ok, id}
    end
  end
  defp save_booking({:error, _reason = error}), do: error
end
