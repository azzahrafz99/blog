defmodule BlogWeb.ArticleController do
  import Ecto.Query

  use BlogWeb, :controller

  alias Blog.Repo

  alias Blog.Post
  alias Blog.Post.Article
  alias Blog.Post.Comment

  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    render(conn, "index.html", articles: Post.list_articles())
  end

  def new(conn, _params) do
    user      = conn.assigns.current_user
    user      = Repo.preload(user, :profile)
    changeset = Article.changeset(%Article{}, %{})
    render(conn, "new.html", changeset: changeset, profile: user.profile)
  end

  def show(conn, %{"id" => id}) do
    article           = Post.get_article!(id)
    article           = Repo.preload(article, [:user, :comments])
    user              = article.user
    user              = Repo.preload(user, :profile)
    current_user      = conn.assigns.current_user
    current_user      = Repo.preload(current_user, :profile)
    comments          = article.comments
    comments          = Repo.preload(comments, :user)
    comment_changeset = Comment.changeset(%Comment{}, %{})
    render(
      conn, "show.html", article: article,
      current_user: current_user, user: user,
      comment_changeset: comment_changeset, comments: comments
    )
  end

  def create(conn, %{"article" => article_params}) do
    user           = conn.assigns.current_user
    user           = Repo.preload(user, :profile)
    body           = article_params["body"] |> URI.decode |> String.replace("&", "-and-")
    article_params = Map.put(article_params, "body", body)

    case Post.create_article(conn.assigns.current_user, article_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Article Created!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, profile: user.profile)
    end
  end

  def edit(conn, %{"id" => id}) do
    article = Post.get_article!(id)
    changeset = Post.change_article(article)
    render(conn, "edit.html", article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Post.get_article!(id)

    case Post.update_article(article, article_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Article updated")
        |> redirect(to: Routes.article_path(conn, :show, article))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset)
    end
  end
end
