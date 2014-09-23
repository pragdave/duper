# This file is responsible for configuring your application
use Mix.Config

config :duper, :config,
  paths: [
           master_folder: "/Users/dave/tmp/master",
         ]

config :phoenix, Duper.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_duper_key",
  session_secret: "9G&7B*3DUOT)9VRV0T2_8@ZQ2EO11IZ6Q8_1MV_9B#S(P1_=WNK91@F@&M(^P(2&U5",
  catch_errors: true,
  debug_errors: false,
  error_controller: Duper.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
