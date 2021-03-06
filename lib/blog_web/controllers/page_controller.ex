defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  alias Blog.Repo

  alias Blog.Accounts
  alias Blog.Accounts.Profile

  alias Blog.Post

  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    current_user = Repo.preload(current_user, :profile)
    profile      = if current_user, do: get_profile(current_user), else: nil
    render(conn, "index.html", latest_articles: Post.latest_articles(), current_user: current_user, profile: profile)
  end

  defp get_profile(user) do
    if (user.profile), do: user.profile, else: create_profile(user)
  end

  defp create_profile(user) do
    case Repo.insert %Profile{user_id: user.id} do
      {:ok, profile} ->
        profile
    end
  end
end
