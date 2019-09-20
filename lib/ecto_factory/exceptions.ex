defmodule EctoFactory.MissingFactory do
  @moduledoc """
  Raised at runtime when the factory is not defined.
  """
  defexception [:message]

  def exception(factory_name) do
    helper_text = """
    Could not find factory by `:#{factory_name}`.
    Define it in your configuration:

    config :ecto_factory, factories: [
      #{factory_name}: Myapp.EctoModule
    ]
    """

    %__MODULE__{message: helper_text}
  end
end

