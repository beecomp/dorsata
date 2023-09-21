defmodule DorsataWeb.UserRoundLiveTest do
  use DorsataWeb.ConnCase

  import Phoenix.LiveViewTest
  import Dorsata.CompetitionFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_user_round(_) do
    user_round = user_round_fixture()
    %{user_round: user_round}
  end

  describe "Index" do
    setup [:create_user_round]

    test "lists all users_rounds", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/users_rounds")

      assert html =~ "Listing Users rounds"
    end

    test "saves new user_round", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/users_rounds")

      assert index_live |> element("a", "New User round") |> render_click() =~
               "New User round"

      assert_patch(index_live, ~p"/users_rounds/new")

      assert index_live
             |> form("#user_round-form", user_round: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_round-form", user_round: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users_rounds")

      html = render(index_live)
      assert html =~ "User round created successfully"
    end

    test "updates user_round in listing", %{conn: conn, user_round: user_round} do
      {:ok, index_live, _html} = live(conn, ~p"/users_rounds")

      assert index_live |> element("#users_rounds-#{user_round.id} a", "Edit") |> render_click() =~
               "Edit User round"

      assert_patch(index_live, ~p"/users_rounds/#{user_round}/edit")

      assert index_live
             |> form("#user_round-form", user_round: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_round-form", user_round: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users_rounds")

      html = render(index_live)
      assert html =~ "User round updated successfully"
    end

    test "deletes user_round in listing", %{conn: conn, user_round: user_round} do
      {:ok, index_live, _html} = live(conn, ~p"/users_rounds")

      assert index_live |> element("#users_rounds-#{user_round.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#users_rounds-#{user_round.id}")
    end
  end

  describe "Show" do
    setup [:create_user_round]

    test "displays user_round", %{conn: conn, user_round: user_round} do
      {:ok, _show_live, html} = live(conn, ~p"/users_rounds/#{user_round}")

      assert html =~ "Show User round"
    end

    test "updates user_round within modal", %{conn: conn, user_round: user_round} do
      {:ok, show_live, _html} = live(conn, ~p"/users_rounds/#{user_round}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User round"

      assert_patch(show_live, ~p"/users_rounds/#{user_round}/show/edit")

      assert show_live
             |> form("#user_round-form", user_round: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_round-form", user_round: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/users_rounds/#{user_round}")

      html = render(show_live)
      assert html =~ "User round updated successfully"
    end
  end
end
