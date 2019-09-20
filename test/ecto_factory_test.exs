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
      EctoFactory.build(:foo)
    end)
  end

  test "build by directly passing in a schema" do
    user = EctoFactory.build(User)
    assert user
  end

  test "build with attributes" do
    user = EctoFactory.build(User, username: "foo")
    assert user.username == "foo"
  end

  test "build by using defined factory and passed in attributes" do
    user = EctoFactory.build(:user_with_default_username, age: 99)
    assert user.username == "mrmicahcooper"
    assert user.age == 99
  end
end
