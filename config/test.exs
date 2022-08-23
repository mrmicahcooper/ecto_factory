import Config

config :ecto_factory, repo: EctoFactory.Repo

config :ecto_factory,
  factories: [
    user: User,
    default_user: {User},
    user_with_default_username: {User, username: "mrmicahcooper"}
  ]
