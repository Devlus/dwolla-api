defmodule Utilshare.Router do
  use Utilshare.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Utilshare do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/auth", AuthController, :index
    get "/auth/redirect", AuthController, :redirect
    post "/auth", AuthController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", Utilshare do
  #   pipe_through :api
  # end
end
