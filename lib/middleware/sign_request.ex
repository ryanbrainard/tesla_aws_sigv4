defmodule AwsSigV4.Middleware.SignRequest do
  @moduledoc """
  Middleware to sign Tesla requests with AWS SigV4

  This is a simple wrapper around the AWS Signature Version 4 (SigV4) signing process implemented in `ex_aws` in the form of Tesla middleware. This is used to sign manual requests to AWS APIs using Tesla. Note, this does NOT use or support any of the service libraries in `ex_aws`; it is only signing manually constructed requests with SigV4.

  ### Examples

  ```
  defmodule MyClient do
    use Tesla

    plug AwsSigV4.Middleware.SignRequest, service: :ec2
  end
  ```

  ### Options

  - `:service` - Required canonical name of the AWS service used in the signing process.
  - `:config` - Optional overrides for `ex_aws` config. Only config related to the signing process are supported.
  """

  @behaviour Tesla.Middleware

  @impl true
  def call(env, next, opts) do
    service = Keyword.fetch!(opts, :service)

    config =
      ExAws.Config.Defaults.defaults(service)
      |> Map.merge(Keyword.get(opts, :config, %{}))
      |> ExAws.Config.retrieve_runtime_config()

    env
    |> sign_request(service, config)
    |> Tesla.run(next)
  end

  defp sign_request(env, service, config) do
    {:ok, headers} =
      ExAws.Auth.headers(
        env.method(),
        env.url(),
        service,
        config,
        env.headers(),
        env.body() || ""
      )

    Tesla.put_headers(env, headers)
  end
end
