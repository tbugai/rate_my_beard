defmodule RateMyBeard.PageController do
  use RateMyBeard.Web, :controller

  alias RateMyBeard.Entry

  def index(conn, _params) do
    query = from e in Entry,
              order_by: [asc: e.inserted_at]

    entries = Repo.all(query)

    render conn, "index.html", entries: entries
  end
end
