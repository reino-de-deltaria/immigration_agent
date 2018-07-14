defmodule Example.Mixfile do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Example, []}
    ]
  end

  defp deps do
    [
      {:coxir, git: "https://github.com/satom99/coxir.git"}
    ]
  end
end
