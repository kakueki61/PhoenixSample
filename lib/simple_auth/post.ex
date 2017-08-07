defmodule SimpleAuth.Post do
  use Ecto.Schema
  import Ecto.Changeset
  @moduledoc false

  schema "posts" do
    belongs_to :user, SimpleAuth.User

    field :title, :string
    field :body, :string
  end

  @required_fields ~w(title)a
  @optional_fields ~w(body)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end