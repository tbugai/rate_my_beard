defmodule RateMyBeard.PageController do
  use RateMyBeard.Web, :controller

  def index(conn, _params) do
    entries = Repo.all(RateMyBeard.Entry)
    render conn, "index.html", entries: entries
  end
end
