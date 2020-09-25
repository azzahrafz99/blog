defmodule Blog.Accounts do
  alias Blog.Repo
  alias Blog.Accounts.User
  alias Blog.Accounts.Profile
  alias Blog.Post.Article

  import Ecto.Query

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && Bcrypt.check_pass(password, user.password_hash) ->
        {:ok, user}
      true ->
        {:error, :unauthorized}
    end
  end

  def user_signed_in?(conn), do: !!current_user(conn)

  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User, user_id)
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

  def register(params) do
    User.registration_changeset(%User{}, params) |> Repo.insert()
  end

  def get_profile(id), do: Repo.get(Profile, id)

  def get_user(id), do: Repo.get(User, id)

  def latest_articles(user_id) do
    query =
      from article in Article,
      join: user in assoc(article, :user),
      order_by: [desc: article.inserted_at],
      limit: 3,
      where: article.user_id == ^user_id

    Repo.all(
      from [article, user] in query
    )
  end
end
