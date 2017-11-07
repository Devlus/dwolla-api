defmodule Utilshare.PageController do
  use Utilshare.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def create(conn) do
    # https://sandbox.dwolla.com/oauth/v2/authenticate?client_id={c6sHLTxFVDBNgedz56P9gGbmpbx6KL9svNs0BK4Us5mNlDx77H}&response_type=code&redirect_uri=localhost:4000&scope=send|transactions|funding|accountinfofull
  end
end
