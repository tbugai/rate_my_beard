defmodule RateMyBeard.EntryView do
  use RateMyBeard.Web, :view

  def render("entry.json", %{entry: entry}) do
    %{entry: %{id: entry.id, up_votes: entry.up_votes, down_votes: entry.down_votes}}
  end

  # def render("already_voted.json") do
  #   %{error: %{message: "You've already voted on this entry..."}}
  # end
end
