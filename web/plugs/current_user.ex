defmodule RateMyBeard.CurrentUser do
  import Plug.Conn

  alias RateMyBeard.{Repo, User}

  def init(options), do: options

  def call(conn, _options) do
    assign(conn, :current_user, user_from_session(conn))
  end

  defp user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      id  -> Repo.get_by(User, id: id)
    end
  end
end
