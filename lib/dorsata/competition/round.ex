defmodule Dorsata.Competition.Round do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rounds" do
    field :status, Ecto.Enum, values: [:unopened, :open, :closed]
    field :title, :string
    field :shortname, :string
    field :problem_url, :string
    field :open_at, :naive_datetime
    field :championship_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:title, :shortname, :problem_url, :open_at, :status])
    |> validate_required([:title, :shortname, :problem_url, :open_at, :status])
    |> unique_constraint(:shortname)
  end
end
