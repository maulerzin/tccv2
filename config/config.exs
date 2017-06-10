# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tccv2,
  ecto_repos: [Tccv2.Repo]

# Configures the endpoint
config :tccv2, Tccv2.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5sHiIxIwgTSc6CuFB0qzgLvVHXnFUmLItYZMZu6UYagpZX979ador+n3lTHggWbk",
  render_errors: [view: Tccv2.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tccv2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]




# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Tccv2.User,
  repo: Tccv2.Repo,
  module: Tccv2,
  logged_out_url: "/restaurantes",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, Tccv2.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"

  config :policy_wonk, PolicyWonk,
  policies: Tccv2.Policies
# %% End Coherence Configuration %%

import_config "#{Mix.env}.exs"
