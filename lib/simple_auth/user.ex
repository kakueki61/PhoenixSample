defmodule SimpleAuth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SimpleAuth.User


  schema "users" do
    has_many :posts, SimpleAuth.Post

    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean, default: false

    timestamps()
  end

  @required_fields ~w(email)a
  @optional_fields ~w(name is_admin)a

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
