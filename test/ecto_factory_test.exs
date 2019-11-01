defmodule EctoFactoryTest do
  use ExUnit.Case, async: true

  Code.load_file("test/support/user.ex")

  test "missing factory" do
    error_message = """
    Could not find factory by `:foo`.
    Define it in your configuration:

    config :ecto_factory, factories: [
      foo: Myapp.EctoModule
    ]
    """

    assert_raise(EctoFactory.MissingFactory, error_message, fn ->
      EctoFactory.schema(:foo)
    end)
  end

  test "build by directly passing in a schema" do
    user = EctoFactory.schema(User)
    assert user
  end

  test "build with attributes" do
    user = EctoFactory.schema(User, username: "foo")
    assert user.username == "foo"
  end

  test "build by using defined factory and passed in attributes" do
    user = EctoFactory.schema(:user_with_default_username, age: 99)
    assert user.username == "mrmicahcooper"
    assert user.age == 99
  end

  test "build attrs by using defined factory and passed in attributes" do
    user = EctoFactory.attrs(:user_with_default_username, age: 99)
    assert Map.get(user, "username") == "mrmicahcooper"
    assert Map.get(user, "age") == 99
  end

  test "using atoms for attributes for randomly generated things" do
    user = EctoFactory.schema(User, username: :email)
    assert String.match?(user.username, ~r/@/)
  end

  test "using tuples for attributes to randomly generate things" do
    user = EctoFactory.schema(User, username: {:array, :email})
    assert user.username |> List.first() |> String.match?(~r/@/)
  end

  test "getting a string with a set number of characters" do
    assert EctoFactory.gen({:string, 9}) |> String.length() == 9
  end
end
