defmodule User do
  use Ecto.Schema

  schema "users" do
    field(:username)
    field(:age, :integer)
  end
end
