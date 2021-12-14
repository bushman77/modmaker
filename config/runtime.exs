import Config

##production level configurations
if config_env() == :prod do
  config :api, ApiWeb.Endpoint,
    url: [host: "localhost"],
    http: [port: 4000],
    check_origin: 
    [ "http://localhost:4000" 
    ],
    secret_key_base: "nigpH25KTvHLMJCbeQx/MZEf0xqsNKyRTLf62H10vLKnwacFrPdVibNhVVHf1pMb",
    render_errors: [view: ApiWeb.ErrorView, accepts: ~w(html json), layout: false],
    pubsub_server: Api.PubSub,
    live_view: [signing_salt: "d1QLGl8I"],
    cache_static_manifest: "priv/static/cache_manifest.json",
    server: true

  config :frontend, FrontendWeb.Endpoint,
    url: [host: "localhost"],
    http: [port: 4001],
    check_origin: ["http://localhost:4001"],
    secret_key_base: "nigpH25KTvHLMJCbeQx/MZEf0xqsNKyRTLf62H10vLKnwacFrPdVibNhVVHf1pMb",
    render_errors: [view: FrontendWeb.ErrorView, accepts: ~w(html json), layout: true],
    pubsub_server: Frontend.PubSub,
    live_view: [signing_salt: "d1QLGl8I"],
    cache_static_manifest: "priv/static/cache_manifest.json",
    server: true

#  config :mnesia, 
#    dir: './Mnesia.production@severian-System-Product-Name'
  #  dir: './databases/prod'

end

