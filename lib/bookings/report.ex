defmodule FlightBooking.Bookings.Report do
  alias FlightBooking.Bookings.Agent, as: BookingAgent
  alias FlightBooking.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_booking_list()
    File.write(filename, booking_list)
  end

  def create_by_date(from_date, to_date) do
    with {:ok, from_naive_date} <- NaiveDateTime.from_iso8601(from_date), {:ok, to_naive_date} <- NaiveDateTime.from_iso8601(to_date) do
      filtered_booking_list = create_filtered_list(from_date, to_date)

    File.write("report_filtered.csv", filtered_booking_list)
      {:ok, "Report generated successfully"}
    else
      _ -> {:error , "date must be yyyy-MM-dd hh:mm:ss"}
    end
  end

  defp create_filtered_list(from_date, to_date) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.filter(fn map -> filter_by_date(map.complete_date, from_date, to_date) end)
    |> Enum.map(&booking_to_string(&1))
  end

  defp build_booking_list() do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_to_string(&1))
  end

  defp filter_by_date(current_naive_date, from_date, to_date) do
    {:ok, from_naive_date} = NaiveDateTime.from_iso8601(from_date)
    {:ok, to_naive_date} = NaiveDateTime.from_iso8601(to_date)

    cond_1 = :gt == NaiveDateTime.compare(current_naive_date, from_naive_date)
    cond_2 = :lt == NaiveDateTime.compare(current_naive_date, to_naive_date)

    cond_1 && cond_2
  end

  defp booking_to_string(%Booking{user_id: user_id, complete_date: naive_date, from_city: from_city, to_city: to_city}) do
    string_date = NaiveDateTime.to_string(naive_date)
    "#{user_id}, #{from_city}, #{to_city}, #{string_date}\n"
  end
end
