defmodule SdvxWeb.PageController do
  use SdvxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
