defmodule EctoFactory.Repo do

  def insert!(struct) do
    struct |> Map.put(:id, 1)
  end

end
