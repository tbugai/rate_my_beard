defmodule RateMyBeard.DownVote do
  alias RateMyBeard.{Entry, Repo, Vote}

  def record_and_return_vote(conn, id) do
    vote_address = ip_address_string(conn.remote_ip)
    vote = Repo.get_by(Vote, entry_id: id, ip_address: vote_address).preload(:entry)

    if vote do
      {:error, :empty}
    else
      Vote.create_changeset(vote_address, id)
      |> Repo.insert()

      Entry.down_vote(vote.entry)
      |> Repo.update()
    end
  end

  defp ip_address_string(ip_address) do
    ip_address |> Tuple.to_list |> Enum.join(".")
  end
end
