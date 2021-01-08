defmodule BlogWeb.ProfileController do
  use BlogWeb, :controller

  alias Blog.Repo
  alias Blog.Accounts
  alias Blog.Accounts.Profile
  alias BlogWeb.Plugs.AuthUser

  import Plug.Upload

  plug AuthUser when action in [:edit, :update]

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    profile         = Accounts.get_profile(id)
    profile         = Repo.preload(profile, :user)
    latest_articles = Accounts.latest_articles(user_id)
    current_user    = if (conn.assigns.current_user), do: conn.assigns.current_user, else: nil
    current_user    = Repo.preload(current_user, :profile)
    render(conn, "show.html", profile: profile, current_user: current_user, latest_articles: latest_articles)
  end

  def edit(conn, %{"user_id" => user_id, "id" => id}) do
    profile   = Accounts.get_profile(id)
    profile   = Repo.preload(profile, :user)
    current_user    = if (conn.assigns.current_user), do: conn.assigns.current_user, else: nil
    current_user    = Repo.preload(current_user, :profile)
    changeset = Accounts.change_profile(profile)
    render(conn, "edit.html", profile: profile, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"user_id" => user_id, "id" => id, "profile" => profile_params}) do
    profile = Accounts.get_profile(id)
    profile = Repo.preload(profile, :user)

    url = upload_avatar(profile_params)
    profile_params = Map.put(profile_params, "avatar_url", url)

    case Accounts.update_profile(profile, profile_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Profile updated")
        |> redirect(to: Routes.user_profile_path(conn, :show, profile.user, profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  defp upload_avatar(profile_params) do
    if profile_params["avatar"] do
      result = Cloudex.upload(profile_params["avatar"].path) |> elem(1)
      result.url
    end
  end
end
