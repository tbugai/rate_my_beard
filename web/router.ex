defmodule RateMyBeard.Router do
  use RateMyBeard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RateMyBeard.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RateMyBeard do
    pipe_through :browser # Use the default browser stack

    resources "/entry", EntryController, except: [:index]
    resources "/session", SessionController, except: [:index]
    resources "/users", UsersController
    get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", RateMyBeard do
  #   pipe_through :api
  # end
end
