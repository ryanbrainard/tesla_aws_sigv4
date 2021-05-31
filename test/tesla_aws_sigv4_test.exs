defmodule Tesla.Middleware.AwsSigV4Test do
  use ExUnit.Case
  doctest Tesla.Middleware.AwsSigV4
  alias Tesla.Env

  @auth_regex ~r/AWS4-HMAC-SHA256 Credential=(?<access_key_id>\w+)\/(?<date>\d{8})\/(?<region>\w+)\/(?<service>\w+)\/aws4_request,SignedHeaders=host;x-amz-date,Signature=(?<signature>\w+)/

  defmodule EchoClient do
    use Tesla

    plug(
      Tesla.Middleware.AwsSigV4,
      service: :test_service,
      config: %{
        access_key_id: "test_access_key_id",
        secret_access_key: "test_secret_access_key",
        region: "test_region"
      }
    )

    adapter(fn env ->
      case env.url do
        _ ->
          {:ok, %{env | status: 200, body: "ok"}}
      end
    end)
  end

  test "signs request" do
    {:ok, %Env{headers: headers}} = EchoClient.get("https://aws.example.com/ok")
    IO.inspect(headers)

    {_, amz_date} = Enum.find(headers, fn {k, _} -> k == "x-amz-date" end)
    {_, auth} = Enum.find(headers, fn {k, _} -> k == "Authorization" end)
    auth_captures = Regex.named_captures(@auth_regex, auth)

    assert auth_captures["access_key_id"] == "test_access_key_id"
    assert String.starts_with?(amz_date, auth_captures["date"])
    assert auth_captures["region"] == "test_region"
    assert auth_captures["signature"]
    assert auth_captures["service"] == "test_service"
  end
end
