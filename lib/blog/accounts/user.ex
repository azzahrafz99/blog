defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.User

  schema "users" do
    field :email, :string, null: false
    field :password_hash, :string, null: false
    field :username, :string, null: false

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :articles, Blog.Post.Article
    has_many :comments, Blog.Post.Comment

    has_one :profile, Blog.Accounts.Profile

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
    |> validate_length(:username, min: 5, max: 32)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_confirmation(:password)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 100)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      _->
        changeset
    end
  end
end
