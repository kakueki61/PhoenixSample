defmodule SimpleAuth.Admin.UserController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  alias SimpleAuth.User

  def index(conn, _params) do
    users = Repo.all(User)

    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = User |> Repo.get!(id)

    render(conn, :show, user: user)
  end
end
