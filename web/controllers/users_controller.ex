defmodule RateMyBeard.UsersController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.User

  def index(conn, _) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get_by(User, id: id)
    changeset = User.changeset(user, %{})
    if user do
      render(conn, "edit.html", user: user, changeset: changeset)
    else
      redirect(conn, to: users_path(conn, :index))
    end
  end

  def update(conn, %{"user" => user_params, "id" => id}) do
    user = Repo.get_by(User, id: id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> redirect(to: users_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("edit.html", user: user, changeset: changeset)
    end
  end

end
