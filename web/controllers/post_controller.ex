defmodule SimpleAuth.PostController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  alias SimpleAuth.Post
  alias SimpleAuth.User

  plug :scrub_params, "post" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn,assigns.current_user])
  end

  def index(conn, _params, current_user) do
    # here will be an implementation
  end

  def show(conn, %{"id" => id}, current_user) do
  end

  def new(conn, _params, current_user) do
  end

  def create(conn, %{"post" => post_params}, current_user) do
  end

  def edit(conn, %{"id" => id}, current_user) do
  end

  def update(conn, %{"id" => id, "post" => post_params}, current_user) do
  end

  def delete(conn, %{"id" => id}, current_user) do
  end

  defp user_posts(user) do
    assoc(user, :posts)
  end

  defp user_post_by_id(user, post_id) do
    user
    |> user_posts
    |> Repo.get(post_id)
  end

#/users/:id                       SimpleAuth.UserController :show
#/users/:user_id/posts            SimpleAuth.PostController :index
#/users/:user_id/posts/:id/edit   SimpleAuth.PostController :edit
#/users/:user_id/posts/new        SimpleAuth.PostController :new
#/users/:user_id/posts/:id        SimpleAuth.PostController :show
#/users/:user_id/posts            SimpleAuth.PostController :create
#/users/:user_id/posts/:id        SimpleAuth.PostController :update
#/users/:user_id/posts/:id        SimpleAuth.PostController :update
#/users/:user_id/posts/:id        SimpleAuth.PostController :delete
  
end
