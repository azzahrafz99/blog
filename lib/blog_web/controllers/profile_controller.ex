defmodule BlogWeb.ProfileController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias Blog.Repo
  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:edit, :update]

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    profile         = Accounts.get_profile(id)
    profile         = Repo.preload(profile, :user)
    latest_articles = Accounts.latest_articles(user_id)
    current_user    = if (conn.assigns.current_user), do: conn.assigns.current_user, else: nil
    render(conn, "show.html", profile: profile, current_user: current_user, latest_articles: latest_articles)
  end
end
