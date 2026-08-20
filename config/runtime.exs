import Config

# A Burrito binary carries no config file, so the release reads the
# database settings from the environment when it boots.
if config_env() == :prod do
  config :weftspun_studio, WeftspunStudio.Repo,
    database: System.get_env("WEFTSPUN_DB_PATH", "/data/weftspun_studio.db"),
    pool_size: String.to_integer(System.get_env("WEFTSPUN_DB_POOL", "5"))
end

# RFD 0076: usd_viewer_app runs as its own app now, reached over
# HTTP. Not gated on config_env() == :prod: a Burrito binary reads
# this at actual runtime the same way it reads WEFTSPUN_DB_PATH.
config :weftspun_studio, :gallery_url, System.get_env("GALLERY_URL", "http://localhost:8090")
