<h1>
<img width="400" src="/logos/ectofactory_logo_text.png"/>
</h1>
<img src="https://travis-ci.org/mrmicahcooper/ecto_factory.svg?branch=master" alt="Build Status">


Easily generate data based on your ecto schemas.

[Hex docs homepage](https://hexdocs.pm/ecto_factory/api-reference.html)

## Installation

Add ecto_factory to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_factory, "~> 0.1.0"}
  ]
end
```

# Usage

Assume we're using the following `User` module:

```elixir
defmodule User do
  use Ecto.Schema

  schema "users" do
    field :age, :integer
    field :username, :string
    field :date_of_birth, :date
    field :address, :map
  end
end

```

Now you can use EctoFactory to generate a Ecto
struct with random data for each of your differnt
fields

```elixir
  EctoFactory.schema(User)

  #=> %User{
    age: 230419832, #random number for an :integer
    username: aduasdaitquweofads, #random string for a :string
    date_of_birth: ~D[2019-10-10], #today for a :date
    address: %{ #random map of string for a :map
      "aduiasdoufp" => "eruiqweu"
      "wfhsddha" => "uudfadsuyanbasvasd"
    }
  }
```

You can set defaults in your config:


```elixir
# config/config.exs

config :ecto_factory, factories: [
  user_with_defaults: { User, [
    age: 99,
    username: "mrmicahcooper",
    date_of_birth: Date.from_iso8601!("2012-12-12")
  ] }
]
```

Which will allow you to do the following:

```elixir

EctoFactory.schema(:user_with_defaults)

#=> %User{
  age: 99
  username: "mrmicahcooper"
  date_of_birth: ~D[2012-12-12]
  address: %{
    "aduiasdoufp" => "eruiqweu"
    "wfhsddha" => "uudfadsuyanbasvasd"
  }
}

```

Notice the `:address` is still random data

And if you don't want to use random data or defaults,
you can specify your attributes at runtime:

```elixir
EctoFactory.schema(User,
  username: "foo",
  age: 2,
  date_of_birth: ~D[2019-01-01],
  address: %{},
)

#=> %User{
  address: %{}
  age: 2,
  date_of_birth: ~d[2019-01-01],
  username: "foo",
}
```

You can also use EctoFactory's own generators to
create radom data. You can do this when specifying
attributes:

```elixir
EctoFactory.attrs(User,
  username: :string, # random string
  email: :email, # random email
  address: {:map, :integer}, # map where the keys are random strings, and the values are random integers
)

#=> %User{
  "address" => %{
    "aduiasdoufp" => 12387128412,
    "wfhsaaddha" => 1238194012
  },
  "age" => 1293812931,
  "date_of_birth" => ~d[2019-01-01],
  "username" => "asdlfkjad",
}

EctoFactory.atomized_attrs(User)

#=> %User{
  address: %{
    "aduiasdoufp" => 12387128412,
    "wfhsaaddha" => 1238194012
  },
  age: 1293812931,
  date_of_birth: ~d[2019-01-01],
  username: "asdlfkjad",
}
```

You can also just call these straight from
EctoFactory with `&Ectofactory.gen/1`:

```elixir
EctoFactory.gen(:id)
# => 1204918243915 # randome integer

EctoFactory.gen(:binary_id)
# => "7D654105-F75D-4E73-8B97-BC7CE1E51EDA" # uuid

EctoFactory.gen(:email)
# => "yjlsbxdcyqhcwswwhv@ogrlycqeycqezslb.omuaqbhpqjmqtnbifoa" #email composed of a bunch of random strings
```

Here is a full list of the random things you can
create. Notice this is a 1-1 mapping of Ecto's
default data types with 1 (more to come)
convenience type - `:email`

```
  :id
  :binary_id
  :integer
  :float
  :decimal
  :boolean
  :binary
  :date
  :time
  :time_usec
  :naive_datetime
  :naive_datetime_usec
  :utc_datetime
  :utc_datetime_usec
  :string
  :array
  {:array, type}
  :map
  {:map, type}
  :email
```

## Development

```
$ git clone https://github.com/mrmicahcooper/ecto_factory
$ cd ecto_factory
$ mix deps.get
$ mix test
```
