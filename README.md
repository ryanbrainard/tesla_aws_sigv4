# TeslaAwsSigV4

Middleware to sign Tesla requests with AWS SigV4

This is a simple wrapper around the [AWS Signature Version 4 (SigV4)](https://github.com/teamon/tesla#middleware) signing process [implemented](https://github.com/ex-aws/ex_aws/blob/master/lib/ex_aws/auth.ex) in [`ex_aws`](https://github.com/ex-aws/ex_aws) in the form of [Tesla middleware](https://github.com/teamon/tesla#middleware). This is used to sign manual requests to AWS APIs using Tesla. Note, this does NOT use or support any of the service libraries in `ex_aws`; it is only signing manually constructed requests with SigV4.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tesla_aws_sigv4` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tesla_aws_sigv4, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tesla_aws_sigv4](https://hexdocs.pm/tesla_aws_sigv4).

