import Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "postgres",
  password: "123$%^",
  hostname: "localhost"

config :friends, ecto_repos: [Friends.Repo]
