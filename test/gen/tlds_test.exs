defmodule Gen.TldsTest do
  use ExUnit.Case, async: true

  describe "random" do
    test "picks a random tld" do
      tld = Gen.Tlds.random()
      assert tld in Gen.Tlds.list()
    end
  end
end
