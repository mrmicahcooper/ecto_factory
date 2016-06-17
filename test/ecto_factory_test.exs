defmodule EctoFactoryTest do
  use ExUnit.Case, async: true

  Code.load_file("test/user.ex")
  Code.load_file("test/repo.ex")
  # config/test.exs

  doctest EctoFactory

  test "missing factory" do
    error_message = "Missing factory :foo"

    assert_raise(RuntimeError, error_message, fn ->
      EctoFactory.build(:foo)
    end)
  end

end
