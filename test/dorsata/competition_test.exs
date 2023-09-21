defmodule Dorsata.CompetitionTest do
  use Dorsata.DataCase

  alias Dorsata.Competition

  describe "championships" do
    alias Dorsata.Competition.Championship

    import Dorsata.CompetitionFixtures

    @invalid_attrs %{title: nil, shortname: nil}

    test "list_championships/0 returns all championships" do
      championship = championship_fixture()
      assert Competition.list_championships() == [championship]
    end

    test "get_championship!/1 returns the championship with given id" do
      championship = championship_fixture()
      assert Competition.get_championship!(championship.id) == championship
    end

    test "create_championship/1 with valid data creates a championship" do
      valid_attrs = %{title: "some title", shortname: "some shortname"}

      assert {:ok, %Championship{} = championship} = Competition.create_championship(valid_attrs)
      assert championship.title == "some title"
      assert championship.shortname == "some shortname"
    end

    test "create_championship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Competition.create_championship(@invalid_attrs)
    end

    test "update_championship/2 with valid data updates the championship" do
      championship = championship_fixture()
      update_attrs = %{title: "some updated title", shortname: "some updated shortname"}

      assert {:ok, %Championship{} = championship} = Competition.update_championship(championship, update_attrs)
      assert championship.title == "some updated title"
      assert championship.shortname == "some updated shortname"
    end

    test "update_championship/2 with invalid data returns error changeset" do
      championship = championship_fixture()
      assert {:error, %Ecto.Changeset{}} = Competition.update_championship(championship, @invalid_attrs)
      assert championship == Competition.get_championship!(championship.id)
    end

    test "delete_championship/1 deletes the championship" do
      championship = championship_fixture()
      assert {:ok, %Championship{}} = Competition.delete_championship(championship)
      assert_raise Ecto.NoResultsError, fn -> Competition.get_championship!(championship.id) end
    end

    test "change_championship/1 returns a championship changeset" do
      championship = championship_fixture()
      assert %Ecto.Changeset{} = Competition.change_championship(championship)
    end
  end

  describe "rounds" do
    alias Dorsata.Competition.Round

    import Dorsata.CompetitionFixtures

    @invalid_attrs %{status: nil, title: nil, shortname: nil, problem_url: nil, open_at: nil}

    test "list_rounds/0 returns all rounds" do
      round = round_fixture()
      assert Competition.list_rounds() == [round]
    end

    test "get_round!/1 returns the round with given id" do
      round = round_fixture()
      assert Competition.get_round!(round.id) == round
    end

    test "create_round/1 with valid data creates a round" do
      valid_attrs = %{status: :unopened, title: "some title", shortname: "some shortname", problem_url: "some problem_url", open_at: ~N[2023-09-20 17:17:00]}

      assert {:ok, %Round{} = round} = Competition.create_round(valid_attrs)
      assert round.status == :unopened
      assert round.title == "some title"
      assert round.shortname == "some shortname"
      assert round.problem_url == "some problem_url"
      assert round.open_at == ~N[2023-09-20 17:17:00]
    end

    test "create_round/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Competition.create_round(@invalid_attrs)
    end

    test "update_round/2 with valid data updates the round" do
      round = round_fixture()
      update_attrs = %{status: :open, title: "some updated title", shortname: "some updated shortname", problem_url: "some updated problem_url", open_at: ~N[2023-09-21 17:17:00]}

      assert {:ok, %Round{} = round} = Competition.update_round(round, update_attrs)
      assert round.status == :open
      assert round.title == "some updated title"
      assert round.shortname == "some updated shortname"
      assert round.problem_url == "some updated problem_url"
      assert round.open_at == ~N[2023-09-21 17:17:00]
    end

    test "update_round/2 with invalid data returns error changeset" do
      round = round_fixture()
      assert {:error, %Ecto.Changeset{}} = Competition.update_round(round, @invalid_attrs)
      assert round == Competition.get_round!(round.id)
    end

    test "delete_round/1 deletes the round" do
      round = round_fixture()
      assert {:ok, %Round{}} = Competition.delete_round(round)
      assert_raise Ecto.NoResultsError, fn -> Competition.get_round!(round.id) end
    end

    test "change_round/1 returns a round changeset" do
      round = round_fixture()
      assert %Ecto.Changeset{} = Competition.change_round(round)
    end
  end

  describe "submissions" do
    alias Dorsata.Competition.Submission

    import Dorsata.CompetitionFixtures

    @invalid_attrs %{status: nil, files: nil}

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Competition.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Competition.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      valid_attrs = %{status: :unlocked, files: ["option1", "option2"]}

      assert {:ok, %Submission{} = submission} = Competition.create_submission(valid_attrs)
      assert submission.status == :unlocked
      assert submission.files == ["option1", "option2"]
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Competition.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      update_attrs = %{status: :locked, files: ["option1"]}

      assert {:ok, %Submission{} = submission} = Competition.update_submission(submission, update_attrs)
      assert submission.status == :locked
      assert submission.files == ["option1"]
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Competition.update_submission(submission, @invalid_attrs)
      assert submission == Competition.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Competition.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Competition.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Competition.change_submission(submission)
    end
  end

  describe "users_rounds" do
    alias Dorsata.Competition.UserRound

    import Dorsata.CompetitionFixtures

    @invalid_attrs %{}

    test "list_users_rounds/0 returns all users_rounds" do
      user_round = user_round_fixture()
      assert Competition.list_users_rounds() == [user_round]
    end

    test "get_user_round!/1 returns the user_round with given id" do
      user_round = user_round_fixture()
      assert Competition.get_user_round!(user_round.id) == user_round
    end

    test "create_user_round/1 with valid data creates a user_round" do
      valid_attrs = %{}

      assert {:ok, %UserRound{} = user_round} = Competition.create_user_round(valid_attrs)
    end

    test "create_user_round/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Competition.create_user_round(@invalid_attrs)
    end

    test "update_user_round/2 with valid data updates the user_round" do
      user_round = user_round_fixture()
      update_attrs = %{}

      assert {:ok, %UserRound{} = user_round} = Competition.update_user_round(user_round, update_attrs)
    end

    test "update_user_round/2 with invalid data returns error changeset" do
      user_round = user_round_fixture()
      assert {:error, %Ecto.Changeset{}} = Competition.update_user_round(user_round, @invalid_attrs)
      assert user_round == Competition.get_user_round!(user_round.id)
    end

    test "delete_user_round/1 deletes the user_round" do
      user_round = user_round_fixture()
      assert {:ok, %UserRound{}} = Competition.delete_user_round(user_round)
      assert_raise Ecto.NoResultsError, fn -> Competition.get_user_round!(user_round.id) end
    end

    test "change_user_round/1 returns a user_round changeset" do
      user_round = user_round_fixture()
      assert %Ecto.Changeset{} = Competition.change_user_round(user_round)
    end
  end
end
