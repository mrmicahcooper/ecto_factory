defmodule User do
  use Ecto.Schema

  schema "users" do
    field(:username)
    field(:age, :integer)
    field(:date_of_birth, :date)
    field(:addresses, {:array, :string})
    field(:profile, :map)
  end
end
