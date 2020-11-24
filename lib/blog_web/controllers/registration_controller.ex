defmodule BlogWeb.RegistrationController do
  import Ecto.Query

  use BlogWeb, :controller

  alias Blog.Repo
  alias Blog.Accounts
  alias Blog.Accounts.Profile

  def new(conn, _) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, %{"registration" => registration_params}) do
    case Accounts.register(registration_params) do
      {:ok, user} ->
        conn
        |> Repo.insert %Profile{user_id: user.id}
        |> Repo.preload(user, :profile)
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You've Signed up and Signed in!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
