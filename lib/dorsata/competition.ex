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

  alias Dorsata.Competition.Round

  @doc """
  Returns the list of rounds.

  ## Examples

      iex> list_rounds()
      [%Round{}, ...]

  """
  def list_rounds do
    Repo.all(Round)
  end

  @doc """
  Gets a single round.

  Raises `Ecto.NoResultsError` if the Round does not exist.

  ## Examples

      iex> get_round!(123)
      %Round{}

      iex> get_round!(456)
      ** (Ecto.NoResultsError)

  """
  def get_round!(id), do: Repo.get!(Round, id)

  @doc """
  Creates a round.

  ## Examples

      iex> create_round(%{field: value})
      {:ok, %Round{}}

      iex> create_round(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_round(attrs \\ %{}) do
    %Round{}
    |> Round.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a round.

  ## Examples

      iex> update_round(round, %{field: new_value})
      {:ok, %Round{}}

      iex> update_round(round, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_round(%Round{} = round, attrs) do
    round
    |> Round.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a round.

  ## Examples

      iex> delete_round(round)
      {:ok, %Round{}}

      iex> delete_round(round)
      {:error, %Ecto.Changeset{}}

  """
  def delete_round(%Round{} = round) do
    Repo.delete(round)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking round changes.

  ## Examples

      iex> change_round(round)
      %Ecto.Changeset{data: %Round{}}

  """
  def change_round(%Round{} = round, attrs \\ %{}) do
    Round.changeset(round, attrs)
  end

  alias Dorsata.Competition.Submission

  @doc """
  Returns the list of submissions.

  ## Examples

      iex> list_submissions()
      [%Submission{}, ...]

  """
  def list_submissions do
    Repo.all(Submission)
  end

  @doc """
  Gets a single submission.

  Raises `Ecto.NoResultsError` if the Submission does not exist.

  ## Examples

      iex> get_submission!(123)
      %Submission{}

      iex> get_submission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_submission!(id), do: Repo.get!(Submission, id)

  @doc """
  Creates a submission.

  ## Examples

      iex> create_submission(%{field: value})
      {:ok, %Submission{}}

      iex> create_submission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_submission(attrs \\ %{}) do
    %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a submission.

  ## Examples

      iex> update_submission(submission, %{field: new_value})
      {:ok, %Submission{}}

      iex> update_submission(submission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_submission(%Submission{} = submission, attrs) do
    submission
    |> Submission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a submission.

  ## Examples

      iex> delete_submission(submission)
      {:ok, %Submission{}}

      iex> delete_submission(submission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_submission(%Submission{} = submission) do
    Repo.delete(submission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking submission changes.

  ## Examples

      iex> change_submission(submission)
      %Ecto.Changeset{data: %Submission{}}

  """
  def change_submission(%Submission{} = submission, attrs \\ %{}) do
    Submission.changeset(submission, attrs)
  end

  alias Dorsata.Competition.UserRound

  @doc """
  Returns the list of users_rounds.

  ## Examples

      iex> list_users_rounds()
      [%UserRound{}, ...]

  """
  def list_users_rounds do
    Repo.all(UserRound)
  end

  @doc """
  Gets a single user_round.

  Raises `Ecto.NoResultsError` if the User round does not exist.

  ## Examples

      iex> get_user_round!(123)
      %UserRound{}

      iex> get_user_round!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_round!(id), do: Repo.get!(UserRound, id)

  @doc """
  Creates a user_round.

  ## Examples

      iex> create_user_round(%{field: value})
      {:ok, %UserRound{}}

      iex> create_user_round(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_round(attrs \\ %{}) do
    %UserRound{}
    |> UserRound.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_round.

  ## Examples

      iex> update_user_round(user_round, %{field: new_value})
      {:ok, %UserRound{}}

      iex> update_user_round(user_round, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_round(%UserRound{} = user_round, attrs) do
    user_round
    |> UserRound.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_round.

  ## Examples

      iex> delete_user_round(user_round)
      {:ok, %UserRound{}}

      iex> delete_user_round(user_round)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_round(%UserRound{} = user_round) do
    Repo.delete(user_round)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_round changes.

  ## Examples

      iex> change_user_round(user_round)
      %Ecto.Changeset{data: %UserRound{}}

  """
  def change_user_round(%UserRound{} = user_round, attrs \\ %{}) do
    UserRound.changeset(user_round, attrs)
  end
end
