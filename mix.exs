defmodule TeslaAwsSigV4.MixProject do
  use Mix.Project

  def project do
    [
      app: :tesla_aws_sigv4,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.0"},
      {:ex_aws, "~> 2.1"},

      # TODO: only needed by ex_aws, but we don't use it. how to avoid requiring this?
      {:hackney, "~> 1.0"}
    ]
  end
end
