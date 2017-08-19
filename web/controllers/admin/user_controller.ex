defmodule SimpleAuth.Admin.UserController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  alias SimpleAuth.User

  def index(conn, _params) do
    users = Repo.all(User)

    render(conn, :index, users: users)
  end
  
end
