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

    resources "/entry", EntryController, except: [:index, :update, :edit, :show]
    resources "/session", SessionController, except: [:index, :show, :edit, :update]
    resources "/users", UsersController, except: [:show]
    get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
  scope "/api", RateMyBeard do
    pipe_through :api

    post "/up_vote/:id", EntryController, :up_vote
    post "/down_vote/:id", EntryController, :down_vote
  end
end
