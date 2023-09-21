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
end
