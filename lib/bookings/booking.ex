defmodule FlightBooking.Bookings.Booking do
  alias FlightBooking.Users.User
  @keys [:id, :complete_date, :from_city, :to_city, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(complete_date, from_city, to_city, user)
    when is_bitstring(from_city) and is_bitstring(to_city) do
    complete_date
    |> NaiveDateTime.from_iso8601() 
    |> build_booking(from_city, to_city, user)
  end

  def build(_date, _from_city, _to_city, _user), do: {:error, "Invalid parameters"}

  defp build_booking({:ok, date}, from_city, to_city, %User{id: user_id}) do
    {:ok,                                                        %__MODULE__{
        id: UUID.uuid4(),                                          complete_date: date,
        from_city: from_city,
        to_city: to_city,
        user_id: user_id                                         }
    }
  end

  defp build_booking({:error, _reason}, _from_city, _to_city, _user), do: {:error, "date must be string in format yyyy-MM-dd hh:mm:ss"}
end
