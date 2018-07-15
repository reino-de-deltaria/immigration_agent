use Mix.Config

import_config "#{Mix.env}.exs"

config :goth,
  json: "/Users/isaac.yung/Documents/credentials/creds.json" |> File.read!

config :coxir,
 token: "NDY3ODA1NDYxNjAxODQ1MjQ4.DiwfAg.l8uP0ZS1qtvvxwMOKuSaCgJPQFQ"
