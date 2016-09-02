defmodule RateMyBeard.EntryController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.{Entry, Vote}

  def new(conn, _params) do
    changeset = Entry.changeset(%Entry{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"entry" => entry_params}) do
    changeset = Entry.changeset(%Entry{up_votes: 0, down_votes: 0}, entry_params)

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

  def up_vote(conn, %{"id" => id}) do
    vote_address = ip_address_string(conn.remote_ip)

    entry = Repo.get_by(Entry, id: id)
    vote = Repo.get_by(Vote, entry_id: entry.id, ip_address: vote_address)

    if vote do
      render(conn, "entry.json", entry: entry)
    else
      changeset = Vote.changeset(%Vote{}, %{ip_address: vote_address, entry_id: entry.id})
      Repo.insert(changeset)

      Entry.up_vote(entry)
      |> Repo.update()
      |> case do
        {:ok, entry} ->
          render(conn, "entry.json", entry: entry)
        {:error, _changeset} ->
          render(conn, "error.json")
      end
    end
  end

  def down_vote(conn, %{"id" => id}) do
    vote_address = ip_address_string(conn.remote_ip)

    entry = Repo.get_by(Entry, id: id)
    vote = Repo.get_by(Vote, entry_id: entry.id, ip_address: vote_address)

    if vote do
      render(conn, "entry.json", entry: entry)
    else
      changeset = Vote.changeset(%Vote{}, %{ip_address: vote_address, entry_id: entry.id})
      Repo.insert(changeset)

      Entry.down_vote(entry)
      |> Repo.update()
      |> case do
        {:ok, entry} ->
          render(conn, "entry.json", entry: entry)
        {:error, _changeset} ->
          render(conn, "error.json")
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get_by(Entry, id: id)
    Repo.delete(entry)

    conn
    |> put_flash(:info, "Successfully removed the beard.")
    |> redirect(to: page_path(conn, :index))
  end

  defp ip_address_string(ip_address) do
    ip_address |> Tuple.to_list |> Enum.join(".")
  end
end
