defmodule User do
  use Ecto.Schema

  schema "users" do
    field :username
    field :age, :integer
    field :date_of_birth, Ecto.DateTime
  end
end
