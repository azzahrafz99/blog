defmodule Blog.Post.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :article_id, :id
    field :body, :string

    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :article_id, :user_id])
    |> validate_required([:body])
  end
end
