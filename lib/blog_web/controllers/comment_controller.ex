defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias BlogWeb.Plugs.AuthUser

  plug AuthUser when action in [:new, :create, :edit, :update, :delete]
end
