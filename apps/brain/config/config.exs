# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Frontend

# Configures the endpoint
#config :api, FrontendWeb.Endpoint,
#  url: [host: "localhost"],
#  secret_key_base: "tkq0Th7ZgizOC9L96ClCVEbX/Z6eKTtA8wjez/3Iudk789eHtnnPuYFPMo/1o8Qa",
#  render_errors: [view: FrontendWeb.ErrorView, accepts: ~w(html json)],
#  pubsub: [name: Frontend.PubSub,
#           adapter: Phoenix.PubSub.PG2],
config :phoenix, :json_library, Jason
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :cors_plug,
  origin: ["http://localhost:4001"],
  max_age: 86400,
  methods: ["GET", "POST"]

config :api, FrontendWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4001],
  check_origin: ["http://localhost:4001"],
  secret_key_base: "nigpH25KTvHLMJCbeQx/MZEf0xqsNKyRTLf62H10vLKnwacFrPdVibNhVVHf1pMb",
  render_errors: [view: MlbFrontendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Frontend.PubSub,
  live_view: [signing_salt: "d1QLGl8I"],
  server: true
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
#import_config "#{Mix.env}.exs"
