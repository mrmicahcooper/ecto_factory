defmodule EctoFactoryTest do
  use ExUnit.Case, async: true

  Code.load_file("test/user.ex")
  Code.load_file("test/repo.ex")
  # config/test.exs

  doctest EctoFactory

  test "missing factory" do
    error_message = """
      Could not find factory by `:foo`.
      Define it do your configuration:

      config :ecto_factory, factories: [
        foo: Myapp.EctoModule
      ]
    """
    assert_raise(EctoFactory.MissingFactory, error_message, fn ->
      EctoFactory.build(:foo)
    end)
  end

end
