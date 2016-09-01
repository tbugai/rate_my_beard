defmodule RateMyBeard.EntryController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.Entry

  def new(conn, _params) do
    changeset = Entry.changeset(%Entry{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"entry" => entry_params}) do
    changeset = Entry.changeset(%Entry{}, entry_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully added the new beard!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset } ->
        conn
        |> put_flash(:error, "Oops!  Something went wrong trying to create the beard.")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get_by(Entry, id: id)
    Repo.delete(entry)

    conn
    |> put_flash(:info, "Successfully removed the beard.")
    |> redirect(to: page_path(conn, :index))
  end
end
