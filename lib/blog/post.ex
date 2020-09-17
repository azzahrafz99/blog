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
end
