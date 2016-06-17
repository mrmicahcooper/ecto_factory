defmodule EctoFactory.MissingFactory do
  @moduledoc """
  Raised at runtime when the factory is not defined.
  """
  defexception [:message]

  def exception(factory_name) do
    helper_text = """
      Could not find factory by `:#{factory_name}`.
      Define it do your configuration:

      config :ecto_factory, factories: [
        #{factory_name}: Myapp.EctoModule
      ]
    """
    %__MODULE__{message: helper_text}
  end
end

defmodule EctoFactory.MissingRepo do
  @moduledoc """
  Raised at runtime when trying to insert data without configuring `:repo`
  """

  defexception [:message]

  def exception do
  helper_text =  """
      You must configure `:repo` to insert data.

      config :ecto_factory, `repo`: MyApp.Repo
    """
    %__MODULE__{message: helper_text}
  end

end
