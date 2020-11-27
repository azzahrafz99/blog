defmodule Blog.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  use Arc.Ecto.Schema

  schema "profiles" do
    field :avatar, Blog.ImageUploader.Type
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
    |> cast(attrs, [:first_name, :last_name, :avatar, :bio, :avatar_url])
    |> validate_length(:bio, max: 160)
    |> cast_attachments(attrs, [:avatar])
  end
end
