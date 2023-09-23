defmodule Dorsata.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :shortname, :string
      add :problem_url, :string
      add :open_at, :naive_datetime
      add :status, :string
      add :championship_id, references(:championships, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:rounds, [:shortname, :championship_id])
    create index(:rounds, [:shortname])
    create index(:rounds, [:championship_id])
  end
end
