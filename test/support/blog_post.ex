defmodule BlogPost do
  use Ecto.Schema

  schema "blog_posts" do
    belongs_to :user, User
  end
end
