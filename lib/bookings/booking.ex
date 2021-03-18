defmodule FlightBooking.Bookings.Booking do
  @keys [:id, :complete_date, :from_city, :to_city, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def create_booking(id, complete_date, from_city, to_city, user_id)
    when is_bitstring(from_city) and is_bitstring(to_city) do
    {:ok,
      %__MODULE__{
        id: id,
        complete_date: complete_date,
        from_city: from_city,
        to_city: to_city,
        user_id: user_id
      }
    }
  end

  def reate_booking(_id, _complete_date, _from_city, _to_city, _user_id),
    do: {:error, "Invalid parameters"}
end
