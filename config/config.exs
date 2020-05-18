# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :analysis_history,
  ecto_repos: [AnalysisHistory.Repo]

# Configures the endpoint
config :analysis_history, AnalysisHistoryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oGjCYNrC+LHZxMrwf6ks8orXVc7ljgaUjmagLoFaiuhHwVhXZ4kbqglnGTQ2//88",
  render_errors: [view: AnalysisHistoryWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AnalysisHistory.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ZxFQOLN5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :analysis_history, AnalysisHistory.Guardian,
       issuer: "user_management",
       secret_key: "vdsNJHUptbte5p55rYvsoKF+UiaZB/Se7ZwFDtox8ZR1kgh41hcl7rnbhubM6OR4"

config :new_relic_agent,
  app_name: "Analysis History Elixir App",
  license_key: "eu01xxa31792eae8c04ac5416a05c87a1d9eNRAL"