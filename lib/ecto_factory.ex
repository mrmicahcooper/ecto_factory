defmodule EctoFactory do

  @factories Application.get_env(:ecto_factory, :factories)
  @repo Application.get_env(:ecto_factory, :repo)

  @doc """
  Create a struct of the passed in factory

  After configuring a factory

      config :ecto_factory, factories: [
        user: User,

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
  def build(factory_name, attrs \\ []) do
    {model, attributes} = build_attrs(factory_name, attrs)
    struct(model, attributes)
  end

  @doc """
  Insert a factory into the database.

  __NOTE:__ Be sure to set ecto_factory's `:repo` configuration before you use `insert/2`.

      config :ecto_factory, repo: MyApp.Repo

  ### Example

      iex> EctoFactory.insert(:user, age: 99, username: "hashrocket")
      %User{
        id: 1,
        age: 99,
        username: "hashrocket",
        date_of_birth: Ecto.DateTime.utc
      }

  """
  def insert(factory_name, attrs \\[]) do
    unless @repo, do: raise(@missing_repo_message)
    struct = build(factory_name, attrs)
    @repo.insert!(struct)
  end

  defp build_attrs(factory_name, attributes) do
    {model, defaults} = factory(factory_name)
    attrs = model.__changeset__
              |> remove_primary_key(model)
              |> Enum.to_list()
              |> Enum.map(&cast/1)
              |> Keyword.merge(defaults)
              |> Keyword.merge(attributes)
    {model, attrs}
  end

  defp factory(factory_name) do
    case @factories[factory_name] do
      nil               -> raise(EctoFactory.MissingFactory, factory_name)
      {model, defaults} -> {model, defaults}
      {model}           -> {model, []}
      model             -> {model, []}
    end
  end

  defp remove_primary_key(model_changeset, model) do
    case model.__schema__(:autogenerate_id) do
      {primary_key, _} -> Map.delete(model_changeset, primary_key)
      _else            -> model_changeset
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
