defmodule Blog.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :avatar, :string
    field :first_name, :string
    field :last_name, :string

    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :avatar])
  end
end
