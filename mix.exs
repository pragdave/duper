defmodule Duper.Mixfile do
  use Mix.Project


  def project do
    [
      app: :duper,
      version: "0.0.1",
      elixir: ">= 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps 
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Duper, [] },
      applications: [
        :cowboy, 
        :ecto, 
        :logger,
        :phoenix, 
        :postgrex, 
      ]
    ]
  end

  defp deps do
    [
      postgrex:   ">= 0.0.0",
      ecto:       "~> 0.2.0",
      dir_walker: ">=0.0.0",
      phoenix:    ">=0.4.1",
      cowboy:     "~>1.0.0"
    ]
  end
end
