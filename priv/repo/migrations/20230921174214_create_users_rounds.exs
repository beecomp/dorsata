defmodule Dorsata.Repo.Migrations.CreateUsersRounds do
  use Ecto.Migration

  def change do
    create table(:users_rounds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :round_id, references(:rounds, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:users_rounds, [:user_id])
    create index(:users_rounds, [:round_id])
  end
end
