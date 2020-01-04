defmodule SdvxWeb.Router do
  use SdvxWeb, :router

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

  pipeline :admin do
    plug BasicAuth, use_config: {:sdvx, :auth}
  end

  scope "/", SdvxWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", SdvxWeb do
    pipe_through :browser
    pipe_through :admin

    resources "/songs/:song_id/charts", ChartController
    resources "/songs", SongController
  end

  scope "/api", SdvxWeb do
    pipe_through :api

    get "/songs", Api.SongController, :get
  end
end
