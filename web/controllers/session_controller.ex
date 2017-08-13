defmodule SimpleAuth.SessionController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  import Comeonin.Pbkdf2, only: [checkpw: 2, dummy_checkpw: 0]

  alias SimpleAuth.User

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    # try to get user by unique email from DB
    user = Repo.get_by(User, email: email)

    # examine the result
    result = cond do
      # if user was found and provided password hash equals to stored hash
      user && checkpw(password, user.password_hash) ->
        { :ok, login(conn, user) }
      # else if we just found the user
      user ->
        { :error, :unauthorized, conn }
      # otherwise
      true ->
        # simulate check password hash timing
        dummy_checkpw
        { :error, :not_found, conn }
    end

    case result do
      { :ok, conn } ->
        conn
        |> put_flash(:info, "You're now logged in!")
        |> redirect(to: page_path(conn, :index))
      { :error, _reason, conn } ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render(:new)
    end
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def delete(conn, _) do
    # here will be an implementation
  end
  
end
