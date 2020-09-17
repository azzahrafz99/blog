defmodule BlogWeb.ArticleController do
  use BlogWeb, :controller

  alias Blog.Post
  alias Blog.Post.Article
  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:edit, :update, :delete]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do
    case Post.create_article(conn.assigns.current_user, article_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Article Created!")
        |> redirect(to: Routes.article_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp auth_user(conn, _params) do
    if conn.assigns.signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to be signed in")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
