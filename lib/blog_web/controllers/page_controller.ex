defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Talk.Room
  alias Blog.Talk
  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:edit, :update, :delete]

  def index(conn, _params) do
    render(conn, "index.html")
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
