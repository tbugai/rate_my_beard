defmodule RateMyBeard.PageController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.Entry

  def index(conn, _params) do
    entries = Entry |> Entry.ordered |> Repo.all()
    render conn, "index.html", entries: entries
  end
end
