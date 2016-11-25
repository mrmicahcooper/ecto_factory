<h1> <img width="400" src="/logos/ectofactory_logo_text.png"/></h1>


Easily generate structs based on your ecto schemas.

[Hex docs homepage](https://hexdocs.pm/ecto_factory/api-reference.html)

## Installation

Add ecto_factory to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ecto_factory, "~> 0.0.5"}]
end
```

Configure your `repo` for EctoFactory:

Using the following `MyApp.User` module:

```elixir
defmodule MyApp.User do
  use Ecto.Schema

  schema "users" do
    field :age, :integer
    field :username, :string
    field :date_of_birth, Ecto.DateTime
  end
end

```

Configure ecto_factory factories and the `repo` to be used for inserting:

```elixir
# config/config.exs

config :ecto_factory, repo: MyApp.Repo
config :ecto_factory, factories: [
  user: MyApp.User,

  user_with_defaults: { MyApp.User, [
    age: 99,
    username: "mrmicahcooper",
    date_of_birth: Ecto.DateTime.cast!("2012-12-12"),
  ] }
]
```

And that's it. Now use `EctoFactory.build` to create structs.

```elixir
EctoFactory.build(:user) 
#=> %MyApp.User{age: 1, username: "username, date_of_birth: #Ecto.DateTime<2016-06-14T17:03:22Z>}

EctoFactory.build(:user, username: "hashrocket")
#=> %MyApp.User{age: 1, username: "hashrocket, date_of_birth: #Ecto.DateTime<2016-06-14T17:03:22Z>}

EctoFactory.build(:user_with_defaults)
#=> %MyApp.User{age: 99, username: "mrmicahcooper, date_of_birth: #Ecto.DateTime<2012-12-12T00:00:00Z>}

```

EctoFactory uses the fields you've defined in your schema to create some basic data that can be easily overwritten with a very small amount of configuration.

### Development

```
$ git clone https://github.com/mrmicahcooper/ecto_factory
$ cd ecto_factory
$ mix deps.get
$ mix test
```
