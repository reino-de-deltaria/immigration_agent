defmodule ImmigrationAgent.Mixfile do
  use Mix.Project

  def project do
    [
      app: :immigration_agent,
      version: "0.1.0",
      elixir: "~> 1.6.5",
      build_embedded: Mix.env == :dev,
      start_permanent: Mix.env == :dev,
      deps: deps(),
      test_coverage: [tool: Coverex.Task]
    ]
  end

  def application do
    [
      extra_applications:
      [
        :cachex,
        :logger,
        :poolboy,
        :mongodb
      ],
      mod: {ImmigrationAgent, []}
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.0"},
      {:coxir, git: "https://github.com/satom99/coxir.git"},
      {:mongodb, "~> 0.4"},
      {:earmark, "~> 1.2"},
      {:poolboy, "~> 1.5"},
      {:cachex, "~> 3.0"},
      {:confex, "~> 3.3"},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:coverex, "~> 1.4", only: [:test, :dev]},
      {:mock, "~> 0.3", only: :test}
    ]
  end
end
