defmodule RateMyBeard.SessionController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    user = Repo.get_by(User, email: email)
    if user && check_password(password, user.hashed_password) do
      conn
      |> put_flash(:info, "Welcome back, #{user.name}!")
      |> put_session(:current_user_id, user.id)
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Unknown email/password combination")
      |> render("new.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end

  defp check_password(password, hashed) do
    Comeonin.Bcrypt.checkpw(password, hashed)
  end
end
