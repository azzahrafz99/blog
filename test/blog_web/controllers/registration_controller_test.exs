defmodule BlogWeb.RegistrationControllerTest do
  use BlogWeb.ConnCase

  @valid_attrs %{username: "john.doe", email: "john@sample.com", password: "password", password_confirmation: "password"}
  @invalid_attrs %{username: "john", email: "john@sample.com", password: "password", password_confirmation: "password"}

  describe "new" do
    test "registration new", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign Up"
    end
  end

  describe "create user" do
    test "redirects to page index when user is valid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), registration: @valid_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "show errors when user is invalid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), registration: @invalid_attrs)

      assert html_response(conn, 200) =~ "should be at least 5 character(s)"
    end
  end
end
