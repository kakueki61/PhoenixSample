defmodule SimpleAuth.PostController do
  @moduledoc false
  use SimpleAuth.Web, :controller

  alias SimpleAuth.Post
  alias SimpleAuth.User

  plug :scrub_params, "post" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, %{"user_id" => user_id}, current_user) do
    user = User |> Repo.get!(user_id)

    posts =
      user
      |> user_posts
      |> Repo.all
      |> Repo.preload(:user)

    render(conn, "index.html", posts: posts, user: user)
  end

  def show(conn, %{"user_id" => user_id, "id" => id}, _current_user) do
    user = User |> Repo.get!(user_id)

    post = user |> user_post_by_id(id) |> Repo.preload(:user)

    render(conn, "show.html", post: post, user: user)
  end

  def new(conn, _params, current_user) do
    changeset =
      current_user
      |> build_assoc(:posts)
      |> Post.changeset

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}, current_user) do
    changeset =
      current_user
      |> build_assoc(:posts)
      |> Post.changeset(post_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Post was created successfully")
        |> redirect(to: user_post_path(conn, :index, current_user.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset)
    end
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
