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

  @doc """
  Generate a unique round shortname.
  """
  def unique_round_shortname, do: "some shortname#{System.unique_integer([:positive])}"

  @doc """
  Generate a round.
  """
  def round_fixture(attrs \\ %{}) do
    {:ok, round} =
      attrs
      |> Enum.into(%{
        status: :unopened,
        title: "some title",
        shortname: unique_round_shortname(),
        problem_url: "some problem_url",
        open_at: ~N[2023-09-20 17:17:00]
      })
      |> Dorsata.Competition.create_round()

    round
  end

  @doc """
  Generate a submission.
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        status: :unlocked,
        files: ["option1", "option2"]
      })
      |> Dorsata.Competition.create_submission()

    submission
  end
end
