defmodule Dorsata.Competition.Championship do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "championships" do
    field :title, :string
    field :shortname, :string

    timestamps()
  end

  @doc false
  def changeset(championship, attrs) do
    championship
    |> cast(attrs, [:title, :shortname])
    |> validate_required([:title, :shortname])
    |> unique_constraint(:shortname)
  end
end
