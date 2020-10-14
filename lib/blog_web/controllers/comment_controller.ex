defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Post
  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:create, :delete]

  def create(conn, %{"comment" => comment_params}) do
    case Post.create_comment(conn.assigns.current_user, comment_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Comment Created!")
        |> redirect(to: Routes.article_path(conn, :show, comment_params["article_id"]))
    end
  end
end
