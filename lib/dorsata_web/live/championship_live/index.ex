defmodule DorsataWeb.ChampionshipLive.Index do
  use DorsataWeb, :live_view

  alias Dorsata.Competition
  alias Dorsata.Competition.Championship

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :championships, Competition.list_championships())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Championship")
    |> assign(:championship, Competition.get_championship!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Championship")
    |> assign(:championship, %Championship{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Championships")
    |> assign(:championship, nil)
  end

  @impl true
  def handle_info({DorsataWeb.ChampionshipLive.FormComponent, {:saved, championship}}, socket) do
    {:noreply, stream_insert(socket, :championships, championship)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    championship = Competition.get_championship!(id)
    {:ok, _} = Competition.delete_championship(championship)

    {:noreply, stream_delete(socket, :championships, championship)}
  end
end
