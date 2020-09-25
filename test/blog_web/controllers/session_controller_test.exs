defmodule BlogWeb.SessionControllerTest do
  use BlogWeb.ConnCase

  alias Blog.Repo
  alias Blog.Accounts.User

  @valid_attrs %{email: "john@sample.com", password: "password"}
  @invalid_attrs %{email: "johns@sample.com", password: "password"}

  setup do
    Repo.insert!(%User {username: "john.doe", email: "john@sample.com", password: "password", password_confirmation: "password"})
    :ok
  end

  describe "new" do
    test "session new", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign In"
    end
  end

  describe "create" do
    test "redirects to page index when user is valid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), session: @valid_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "show errors when user is invalid", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create), session: @invalid_attrs)

      assert html_response(conn, 200) =~ "Invalid Email or Password"
    end
  end

  describe "delete" do
    test "redirects to page index", %{conn: conn} do
      conn = delete(conn, Routes.session_path(conn, :delete))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end
