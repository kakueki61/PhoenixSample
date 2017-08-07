defmodule SimpleAuth.SessionController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  plug :scrub_params, "session" when actoin in ~w(create)a

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    # here will be an implementation
  end

  def delete(conn, _) do
    # here will be an implementation
  end
  
end
