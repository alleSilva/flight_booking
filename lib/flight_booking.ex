defmodule FlightBooking do
  alias FlightBooking.Users.Agent, as: UserAgent
  alias FlightBooking.Users.CreateOrUpdate

  def start_agents, do: UserAgent.start_link(%{})

  defdelegate create_user(params), to: CreateOrUpdate, as: :call
end
