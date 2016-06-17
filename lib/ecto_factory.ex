defmodule EctoFactory do
  @models Application.get_env(:ecto_factory, :factories)

  @doc """
  Create a struct of the passed in factory

  After configuring a factory

      config :ecto_factory, factories: [
        user_with_default_username: { User,
          username: "mrmicahcooper"
        }
      ]

  You can build a struct with the attributes from my factory as defaults.

      iex> EctoFactory.build(:user_with_default_username)
      %User{
        age: 1,
        username: "mrmicahcooper",
        date_of_birth: Ecto.DateTime.utc
      }

  And you can pass in your own attributes of course:

      iex> EctoFactory.build(:user, age: 99, username: "hashrocket")
      %User{
        age: 99,
        username: "hashrocket",
        date_of_birth: Ecto.DateTime.utc
      }


  """
  def build(model_name, attrs \\ []) do
    {model, attrs} = build_attrs(model_name, attrs)
    struct(model, attrs)
  end

  defp build_attrs(model_name, attributes) do
    {model, defaults} = factory(model_name)
    attrs = model.__changeset__
              |> remove_primary_key(model)
              |> Enum.to_list()
              |> Enum.map(&cast/1)
              |> Keyword.merge(defaults)
              |> Keyword.merge(attributes)
    {model, attrs}
  end

  defp factory(model_name) do
    case @models[model_name] do
      nil               -> raise "Missing factory :#{model_name}"
      {model, defaults} -> {model, defaults}
      {model}           -> {model, []}
      model             -> {model, []}
    end
  end

  defp remove_primary_key(model_map, model) do
    case model.__schema__(:autogenerate_id) do
      {primary_key, _} -> Map.delete(model_map, primary_key)
      _else            -> model_map
    end
  end

  defp cast({key, :string}),      do: {key, Atom.to_string(key)}
  defp cast({key, :integer}),     do: {key, 1}
  defp cast({key, {:assoc, _}}),  do: {key, []}
  defp cast({key, Ecto.DateTime}) do
    {key, Ecto.DateTime.cast!(:calendar.universal_time) }
  end

  defp cast({key, value}), do: {key, nil}

end
