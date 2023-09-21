defmodule Dorsata.Competition.UserRound do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users_rounds" do

    field :user_id, :binary_id
    field :round_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user_round, attrs) do
    user_round
    |> cast(attrs, [])
    |> validate_required([])
  end
end
