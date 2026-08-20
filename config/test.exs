import Config

# The suite runs against its own file. Every test case takes a sandbox
# connection, so a test leaves no row behind. The sandbox is the
# adapter's transaction isolation, not a PostgreSQL feature.
config :weftspun_studio, WeftspunStudio.Repo,
  database:
    System.get_env("WEFTSPUN_DB_PATH", Path.expand("../weftspun_studio_test.db", __DIR__)),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 5

config :logger, level: :warning
