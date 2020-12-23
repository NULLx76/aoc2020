defmodule AoC2020.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc2020,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [aoc2020rs: []],
      dialyzer: [
        plt_add_apps: [:mix],
        flags: [:unmatched_returns, :error_handling, :race_conditions, :underspecs]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:benchwarmer, "~> 0.0.2"},
      {:combination, "~> 0.0.3"},
      {:rustler, "~> 0.21.1"},
      {:erlport, "~> 0.9"}
    ]
  end
end
