defmodule EctoFactoryTest do
  use ExUnit.Case, async: true

  Code.load_file("test/user.ex")
  Code.load_file("test/repo.ex")
  # config/test.exs

  doctest EctoFactory

  test "missing factory" do
    error_message = """
    Could not find factory by `:foo`.
    Define it in your configuration:

    config :ecto_factory, factories: [
      foo: Myapp.EctoModule
    ]
    """
    assert_raise(EctoFactory.MissingFactory, error_message, fn ->
      EctoFactory.build(:foo)
    end)
  end

  test "missing repo" do
    error_message = """
    You must configure `:repo` to insert data.

    config :ecto_factory, `repo`: MyApp.Repo
    """

    Application.put_env(:ecto_factory, :repo, nil, [])
    assert_raise(EctoFactory.MissingRepo, error_message, fn ->
      EctoFactory.insert(:user)
    end)
    Application.put_env(:ecto_factory, :repo, EctoFactory.Repo, [])
  end

  test ".insert" do
    user = EctoFactory.insert(:user, age: 99, username: "hashrocket")
    assert user == %User{
      id: 1,
      age: 99,
      username: "hashrocket",
      date_of_birth: Ecto.DateTime.utc
    }
  end

end
