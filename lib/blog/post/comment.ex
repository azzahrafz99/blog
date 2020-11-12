defmodule Blog.Post.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :approved, :boolean
    field :article_id, :id
    field :body, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :article_id, :user_id, :approved])
    |> validate_required([:body])
  end
end
