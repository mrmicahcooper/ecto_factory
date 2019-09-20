defmodule EctoFactory do
<<<<<<< HEAD
=======
  import Enum, only: [random: 1, to_list: 1]

>>>>>>> Simplify tests
  @doc """
  Create a struct of the passed in factory

  After configuring a factory

      config :ecto_factory, factories: [
        user: User,

        user_with_default_username: { User,
          username: "mrmicahcooper"
        }
      ]

  You can build a struct with the attributes from your factory as defaults.

      EctoFactory.build(:user_with_default_username)

      %User{
        age: 124309132# random number
        username: "mrmicahcooper"
      }

  And you can pass in your own attributes of course:


      EctoFactory.build(:user, age: 99, username: "hashrocket")

    %User{
        age: 99,
        username: "hashrocket"
      }

  """
  def build(factory_name, attrs \\ []) do
    {schema, attributes} = build_attrs(factory_name, attrs)
    struct(schema, attributes)
  end

  def build_attrs(factory_name, attributes) do
    {schema, defaults} =
      if function_exported?(factory_name, :__changeset__, 0) do
        {factory_name, []}
      else
        factory(factory_name)
      end

    attrs =
      schema.__changeset__
      |> remove_primary_key(schema)
      |> Enum.map(&cast/1)
      |> Keyword.merge(defaults)
      |> Keyword.merge(attributes)

    {schema, attrs}
  end

  defp factory(factory_name) do
    case factories()[factory_name] do
      nil -> raise(EctoFactory.MissingFactory, factory_name)
      {schema, defaults} -> {schema, defaults}
      {schema} -> {schema, []}
      schema -> {schema, []}
    end
  end

  def remove_primary_key(schema_changeset, schema) do
    case schema.__schema__(:autogenerate_id) do
      {primary_key, _} -> Map.delete(schema_changeset, primary_key)
      _else -> schema_changeset
    end
  end

  def cast({key, {:assoc, %{cardinality: :many}}}), do: {key, []}
  def cast({key, {:assoc, %{cardinality: :one}}}), do: {key, nil}
  def cast({key, data_type}), do: {key, gen(data_type)}

  def factories, do: Application.get_env(:ecto_factory, :factories)

  def gen(:id), do: random(1..9_999_999_999)
  def gen(:binary_id), do: Ecto.UUID.generate()
  def gen(:integer), do: random(1..9_999_999_999)
  def gen(:float), do: (random(99..99999) / random(1..99)) |> Float.round(2)
  def gen(:decimal), do: gen(:float)
  def gen(:boolean), do: random([true, false])
  def gen(:binary), do: Ecto.UUID.generate()
  def gen({:array, type}), do: 1..random(2..9) |> Enum.map(fn _ -> gen(type) end)
  def gen(:string), do: for(_ <- 1..random(8..24), into: "", do: <<random(alphabet())>>)
  def gen(:date), do: Date.utc_today()
  def gen(:time), do: Time.utc_now()
  def gen(:time_usec), do: gen(:time)
  def gen(:naive_datetime), do: NaiveDateTime.utc_now()
  def gen(:naive_datetime_usec), do: gen(:naive_datetime)
  def gen(:utc_datetime), do: DateTime.utc_now()
  def gen(:utc_datetime_usec), do: gen(:utc_datetime)

  def gen(:map) do
    gen({:array, :string})
    |> Enum.map(fn key -> {key, gen(:string)} end)
    |> Enum.into(%{})
  end

  def gen({:map, type}) do
    gen({:array, :string})
    |> Enum.map(fn key -> {key, gen(type)} end)
    |> Enum.into(%{})
  end

  def alphabet, do: to_list(?a..?z) ++ to_list(?0..?9)
end
