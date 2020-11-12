defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias Blog.Post
  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    profile      = if (current_user), do: Accounts.get_profile(current_user.id), else: nil
    render(conn, "index.html", latest_articles: Post.latest_articles(), current_user: current_user, profile: profile)
  end
end