import Config

# A file beside the project. Nothing to start before `mix ecto.migrate`
# works, and no insecure root user to warn anybody about.
config :weftspun_studio, WeftspunStudio.Repo,
  database:
    System.get_env("WEFTSPUN_DB_PATH", Path.expand("../weftspun_studio_dev.db", __DIR__)),
  pool_size: 5

# RFD 0076: usd_viewer_app runs as its own app now (its own `npm
# run start`, or `docker run` from usd_viewer_app/Dockerfile), on
# this default port. WeftspunStudio.Adapters.HttpGallery reaches it
# here in dev.
config :weftspun_studio, :gallery_url, System.get_env("GALLERY_URL", "http://localhost:8090")
