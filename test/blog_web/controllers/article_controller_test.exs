defmodule BlogWeb.ArticleControllerTest do
  use BlogWeb.ConnCase

  @valid_attrs %{title: "Coffee People Vs. Tea People", body: "And if she hasn't been rewritten, then they are still using her. Far far away, behind the word mounta"}

  @invalid_attrs %{title: "", body: "And if she hasn't been rewritten, then they are still using her. Far far away, behind the word mounta"}

  setup do
    Repo.insert!(%User {username: "john.doe", email: "john@sample.com", password: "password", password_confirmation: "password"})
    :ok
  end

  describe "index" do
    test "registration new", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign Up"
    end
  end
end
