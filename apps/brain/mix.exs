defmodule Brain.MixProject do
  use Mix.Project

  def project do
    [
      app: :brain,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :database, :api, :frontend],
      mod: {Brain.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:database, in_umbrella: true},
      {:core_functions, in_umbrella: true},
      {:ships, in_umbrella: true},
      {:api, in_umbrella: true},
      {:frontend, in_umbrella: true}
    ]
  end
end
