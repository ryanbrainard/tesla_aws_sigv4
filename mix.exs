defmodule TeslaAwsSigV4.MixProject do
  use Mix.Project

  @source_url "https://github.com/ryanbrainard/tesla_aws_sigv4"

  def project do
    [
      app: :tesla_aws_sigv4,
      version: "0.1.0",
      description: "Middleware to sign Tesla requests with AWS SigV4",
      source_url: @source_url,
      package: package(),
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:tesla, "~> 1.0"},
      {:ex_aws, "~> 2.1"},

      # TODO: only needed by ex_aws, but we don't use it. how to avoid requiring this?
      {:hackney, "~> 1.0"}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
