defmodule Dorsata.Competition do
  @moduledoc """
  The Competition context.
  """

  import Ecto.Query, warn: false
  alias Dorsata.Repo

  alias Dorsata.Competition.Championship

  @doc """
  Returns the list of championships.

  ## Examples

      iex> list_championships()
      [%Championship{}, ...]

  """
  def list_championships do
    Repo.all(Championship)
  end

  @doc """
  Gets a single championship.

  Raises `Ecto.NoResultsError` if the Championship does not exist.

  ## Examples

      iex> get_championship!(123)
      %Championship{}

      iex> get_championship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_championship!(id), do: Repo.get!(Championship, id)

  @doc """
  Creates a championship.

  ## Examples

      iex> create_championship(%{field: value})
      {:ok, %Championship{}}

      iex> create_championship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_championship(attrs \\ %{}) do
    %Championship{}
    |> Championship.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a championship.

  ## Examples

      iex> update_championship(championship, %{field: new_value})
      {:ok, %Championship{}}

      iex> update_championship(championship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_championship(%Championship{} = championship, attrs) do
    championship
    |> Championship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a championship.

  ## Examples

      iex> delete_championship(championship)
      {:ok, %Championship{}}

      iex> delete_championship(championship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_championship(%Championship{} = championship) do
    Repo.delete(championship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking championship changes.

  ## Examples

      iex> change_championship(championship)
      %Ecto.Changeset{data: %Championship{}}

  """
  def change_championship(%Championship{} = championship, attrs \\ %{}) do
    Championship.changeset(championship, attrs)
  end
end
