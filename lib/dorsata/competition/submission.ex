defmodule Dorsata.Competition.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "submissions" do
    field :status, Ecto.Enum, values: [:unlocked, :locked]
    field :files, {:array, :string}
    field :user_id, :binary_id
    field :round_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:files, :status])
    |> validate_required([:files, :status])
  end
end
