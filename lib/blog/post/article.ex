defmodule Blog.Post.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Post.Article

  schema "articles" do
    field :body, :string
    field :title, :string

    belongs_to :user, Blog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
