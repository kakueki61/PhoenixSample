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
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end

  defp hash_password(changeset) do

    case changeset do
      %Ecto.Changeset{valid?: true,
                     changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Pbkdf2.hashpwsalt(password))
      _ ->
        changeset
    end
  end

end
