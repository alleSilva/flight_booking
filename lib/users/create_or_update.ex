defmodule FlightBooking.Users.CreateOrUpdate do
  alias FlightBooking.Users.Agent, as: UserAgent
  alias FlightBooking.Users.User

  def call(%{name: name, cpf: cpf, email: email}) do
    name
    |> User.build(cpf, email)
    |> save_user()
  end

  defp save_user({:ok, %User{id: id} = user}) do
    case UserAgent.save(user) do
      :ok -> {:ok, id}
    end
  end
  defp save_user({:error, _reason = error}), do: error
end
