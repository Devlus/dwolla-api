defmodule Utilshare.AuthController do
  use Utilshare.Web, :controller
  alias Utilshare.Auth

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def getAccountDetails(auth) do
    IO.inspect(auth)
    auth = Poison.decode!(auth)
    IO.inspect(auth)
    headers = ["Authorization": "Bearer "<>auth["access_token"],
               "Accept": "application/vnd.dwolla.v1.hal+json"]
    url = auth["_links"]
    IO.inspect(url)
    url = url["account"]
    IO.inspect(url)
    url = url["href"]
    IO.inspect(url)
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def getAuthToken(code) do
    body = {:form, 
      [
        client_id: "nQt9sRTqftDZv9S8G2rkbY7KOu0Uh19pPG2sCPCDelP7nEDszs",
        client_secret: "", #withheld
        grant_type: "authorization_code",
        redirect_url: "http://localhost:4000/auth/redirect",
        code: code
    ]}
    
    case HTTPoison.post("https://sandbox.dwolla.com/oauth/v2/token", body, %{"Content-type" => "application/x-www-form-urlencoded"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def redirect(conn, _params) do
    IO.inspect(_params);
    auth = getAuthToken(_params["code"])
    accountDetails = getAccountDetails(auth)
    render(conn, "index.html", auth: auth, details: accountDetails)
  end
  def new(conn, _params) do
    render(conn, "new.html")
  end
end
