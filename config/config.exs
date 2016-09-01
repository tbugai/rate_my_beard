# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rate_my_beard,
  ecto_repos: [RateMyBeard.Repo]

# Configures the endpoint
config :rate_my_beard, RateMyBeard.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yS8iaiBvK6w3HfwBk3B0aQLK88KVH3sc2V+3VO1fgH6fSp6litJoSkKvpdzlmRh2",
  render_errors: [view: RateMyBeard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RateMyBeard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :arc,
  bucket: "rate-my-beard"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
