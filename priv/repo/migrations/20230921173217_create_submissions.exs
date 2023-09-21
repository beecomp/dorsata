defmodule Dorsata.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :files, {:array, :string}
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :round_id, references(:rounds, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:submissions, [:user_id, :round_id])
    create index(:submissions, [:user_id])
    create index(:submissions, [:round_id])
  end
end
