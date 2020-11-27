defmodule Blog.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  use Arc.Ecto.Schema

  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :bio, :string
    field :avatar_url, :string

    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :bio, :avatar_url])
    |> validate_length(:bio, max: 160)
  end
end
