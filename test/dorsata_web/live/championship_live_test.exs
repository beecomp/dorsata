defmodule DorsataWeb.ChampionshipLiveTest do
  use DorsataWeb.ConnCase

  import Phoenix.LiveViewTest
  import Dorsata.CompetitionFixtures

  @create_attrs %{title: "some title", shortname: "some shortname"}
  @update_attrs %{title: "some updated title", shortname: "some updated shortname"}
  @invalid_attrs %{title: nil, shortname: nil}

  defp create_championship(_) do
    championship = championship_fixture()
    %{championship: championship}
  end

  describe "Index" do
    setup [:create_championship]

    test "lists all championships", %{conn: conn, championship: championship} do
      {:ok, _index_live, html} = live(conn, ~p"/championships")

      assert html =~ "Listing Championships"
      assert html =~ championship.title
    end

    test "saves new championship", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/championships")

      assert index_live |> element("a", "New Championship") |> render_click() =~
               "New Championship"

      assert_patch(index_live, ~p"/championships/new")

      assert index_live
             |> form("#championship-form", championship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#championship-form", championship: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/championships")

      html = render(index_live)
      assert html =~ "Championship created successfully"
      assert html =~ "some title"
    end

    test "updates championship in listing", %{conn: conn, championship: championship} do
      {:ok, index_live, _html} = live(conn, ~p"/championships")

      assert index_live |> element("#championships-#{championship.id} a", "Edit") |> render_click() =~
               "Edit Championship"

      assert_patch(index_live, ~p"/championships/#{championship}/edit")

      assert index_live
             |> form("#championship-form", championship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#championship-form", championship: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/championships")

      html = render(index_live)
      assert html =~ "Championship updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes championship in listing", %{conn: conn, championship: championship} do
      {:ok, index_live, _html} = live(conn, ~p"/championships")

      assert index_live |> element("#championships-#{championship.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#championships-#{championship.id}")
    end
  end

  describe "Show" do
    setup [:create_championship]

    test "displays championship", %{conn: conn, championship: championship} do
      {:ok, _show_live, html} = live(conn, ~p"/championships/#{championship}")

      assert html =~ "Show Championship"
      assert html =~ championship.title
    end

    test "updates championship within modal", %{conn: conn, championship: championship} do
      {:ok, show_live, _html} = live(conn, ~p"/championships/#{championship}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Championship"

      assert_patch(show_live, ~p"/championships/#{championship}/show/edit")

      assert show_live
             |> form("#championship-form", championship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#championship-form", championship: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/championships/#{championship}")

      html = render(show_live)
      assert html =~ "Championship updated successfully"
      assert html =~ "some updated title"
    end
  end
end
