defmodule Dorsata.Repo.Migrations.CreateChampionships do
  use Ecto.Migration

  def change do
    create table(:championships, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :shortname, :string

      timestamps()
    end

    create unique_index(:championships, [:shortname])
  end
end
