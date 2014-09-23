use Mix.Config

config :phoenix, Duper.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_duper_key",
  session_secret: "9G&7B*3DUOT)9VRV0T2_8@ZQ2EO11IZ6Q8_1MV_9B#S(P1_=WNK91@F@&M(^P(2&U5",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


