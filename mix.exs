defmodule EctoFactory.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ecto_factory,
      version: "0.1.1",
      elixir: "~> 1.9.1",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "EctoFactory",
      source_url: "https://github.com/mrmicahcooper/ecto_factory",
      package: package(),
      description: description(),
      deps: deps(),
      aliases: aliases(),
      docs: [
        logo: "./logos/ectofactory_logo.png",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 3.2.1"},
      {:ex_doc, "~> 0.21.2", only: :dev},
      {:earmark, "~> 1.4.0", only: :dev}
    ]
  end

  defp description do
    """
    Easily generate structs based on your ecto schemas.
    """
  end

  defp aliases do
    [
      test: ["test --trace"]
    ]
  end

  defp package do
    [
      name: :ecto_factory,
      licenses: ["Apache 2.0"],
      maintainers: ["Micah Cooper", "Hashrocket"],
      links: %{
        "GitHub" => "https://github.com/mrmicahcooper/ecto_factory"
      }
    ]
  end
end
