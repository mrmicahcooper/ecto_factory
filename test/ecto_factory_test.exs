defmodule EctoFactoryTest do
  use ExUnit.Case
  Code.load_file("test/user.ex")

  doctest EctoFactory

  test "missing factory" do
    assert_raise(
      RuntimeError, "Missing factory :missing_factory",
      fn -> EctoFactory.build(:missing_factory) end)
  end

end
