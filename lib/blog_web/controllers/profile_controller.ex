defmodule BlogWeb.ProfileController do
  use BlogWeb, :controller

  alias Blog.Repo
  alias Blog.Accounts
  alias Blog.Accounts.Profile
  alias BlogWeb.Plugs.AuthUser

  import Ecto.Query
  import Plug.Upload

  plug AuthUser when action in [:edit, :update]

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    profile         = Accounts.get_profile(id)
    profile         = Repo.preload(profile, :user)
    latest_articles = Accounts.latest_articles(user_id)
    current_user    = if (conn.assigns.current_user), do: conn.assigns.current_user, else: nil
    render(conn, "show.html", profile: profile, current_user: current_user, latest_articles: latest_articles)
  end

  def edit(conn, %{"user_id" => user_id, "id" => id}) do
    profile   = Accounts.get_profile(id)
    profile   = Repo.preload(profile, :user)
    changeset = Accounts.change_profile(profile)
    render(conn, "edit.html", profile: profile, changeset: changeset)
  end

  def update(conn, %{"user_id" => user_id, "id" => id, "profile" => profile_params}) do
    IO.inspect profile_params

    profile = Accounts.get_profile(id)
    profile = Repo.preload(profile, :user)

    url = upload_avatar(profile)
    Map.put(profile_params, "avatar_url", url)

    case Accounts.update_profile(profile, profile_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Profile updated")
        |> redirect(to: Routes.user_profile_path(conn, :show, profile.user, profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  defp upload_avatar(profile) do
    result = Cloudex.upload("uploads/#{profile.avatar.file_name}") |> elem(1)
    result.secure_url
  end
end
