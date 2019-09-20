<h1>
<img width="400" src="/logos/ectofactory_logo_text.png"/>
</h1>
<img src="https://travis-ci.org/mrmicahcooper/ecto_factory.svg?branch=master" alt="Build Status">


Easily generate structs based on your ecto schemas.

[Hex docs homepage](https://hexdocs.pm/ecto_factory/api-reference.html)

## Installation

Add ecto_factory to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ecto_factory, "~> 0.0.7"}]
end
```

Assume we're using the following `MyApp.User` module:

```elixir
defmodule MyApp.User do
  use Ecto.Schema

  schema "users" do
    field :age, :integer
    field :username, :string
    field :date_of_birth, :date
  end
end

```

Configure ecto_factory factories to set some default data:

```elixir
# config/config.exs

config :ecto_factory, factories: [
  user: MyApp.User,

  user_with_defaults: { MyApp.User, [
    age: 99,
    username: "mrmicahcooper",
    date_of_birth: Date.from_iso8601!("2012-12-12"),
  ] }
]
```

And that's it. Now use `EctoFactory.schema` to create structs.

```elixir
EctoFactory.schema(:user)
#=> %MyApp.User{
  age: 23412394123,
  username: "asdjkfads",
  date_of_birth: ~U(2016-06-14T17:03:22Z)
}

EctoFactory.schema(:user, username: "hashrocket")
#=> %MyApp.User{
  age: 23412394123,
  username: "hashrocket",
  date_of_birth: ~U(2016-06-14T17:03:22Z)
}

EctoFactory.schema(:user_with_defaults)
#=> %MyApp.User{
  age: 99,
  username: "mrmicahcooper",
  date_of_birth: ~U(2012-12-12T00:00:00Z>
}

```

EctoFactory uses the fields you've defined in your schema to create random data that can be easily overwritten with a very small amount of configuration.

### Development

```
$ git clone https://github.com/mrmicahcooper/ecto_factory
$ cd ecto_factory
$ mix deps.get
$ mix test
```
