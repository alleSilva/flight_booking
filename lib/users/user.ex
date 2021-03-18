defmodule FlightBooking.Users.User do
  @keys [:id, :name, :cpf, :email]
  @enforce_keys @keys

  defstruct @keys

  def build(name, cpf, email)
    when is_bitstring(cpf) do
    {:ok,
      %__MODULE__{
        id: UUID.uuid4(),
        name: name,
        cpf: cpf,
        email: email,
      }
    }
  end

  def build(_name, _cpf , _email),
    do: {:error, "Invalid parameters"}
end
