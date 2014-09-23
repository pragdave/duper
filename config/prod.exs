use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Duper.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_duper_key",
  session_secret: "9G&7B*3DUOT)9VRV0T2_8@ZQ2EO11IZ6Q8_1MV_9B#S(P1_=WNK91@F@&M(^P(2&U5"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

