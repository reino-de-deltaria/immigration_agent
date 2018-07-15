defmodule ImmigrationAgent.Mixfile do
  use Mix.Project

  def project do
    [
      app: :immigration_agent,
      version: "0.1.0",
      elixir: "~> 1.6.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: Coverex.Task]
    ]
  end

  def application do
    [
      mod: {ImmigrationAgent, []}
    ]

    [
      extra_applications:
      (Mix.env == :dev && [:exsync] || []) ++ [
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
      {:exsync, "~> 0.2", only: :dev},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:coverex, "~> 1.4", only: [:test, :dev]},
      {:mock, "~> 0.3", only: :test}
    ]
  end
end
