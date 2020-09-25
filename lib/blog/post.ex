defmodule Blog.Post do
  alias Blog.Repo
  alias Blog.Post.Article

  import Ecto.Query

  def create_article(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:articles)
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end

  def list_articles do
    Repo.all(Article)
  end

  def get_article!(id), do: Repo.get!(Article, id)

  def latest_articles do
    query =
      from article in Article,
        join: user in assoc(article, :user),
        order_by: [desc: article.inserted_at],
        limit: 3

    Repo.all(
      from [article, user] in query
    )
  end

  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end
end
