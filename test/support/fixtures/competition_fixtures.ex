defmodule Dorsata.CompetitionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dorsata.Competition` context.
  """

  @doc """
  Generate a unique championship shortname.
  """
  def unique_championship_shortname, do: "some shortname#{System.unique_integer([:positive])}"

  @doc """
  Generate a championship.
  """
  def championship_fixture(attrs \\ %{}) do
    {:ok, championship} =
      attrs
      |> Enum.into(%{
        title: "some title",
        shortname: unique_championship_shortname()
      })
      |> Dorsata.Competition.create_championship()

    championship
  end
end
