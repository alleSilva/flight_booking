defmodule FlightBooking.Bookings.Agent do
  use Agent
  alias FlightBooking.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp update_state(state, %Booking{id: id} = booking) do
    Map.put(state, id, booking)
  end

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

end