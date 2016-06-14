defmodule EctoFactory.Mixfile do
  use Mix.Project

  def project do
    [app: :ecto_factory,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 1.1.8"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0"},
    ]
  end

  defp description do
    """
    Easily generate data based on your ecto schemas.
    """
  end

  defp package do
    [
      name: :ecto_factory,
      licenses: ["Apache 2.0"],
      maintainers: ["Micah Cooper", "Hashrocket"],
      links: %{
        "GitHub" => "https://github.com/hashrocket/ecto_factory",
      }
    ]
  end

end
