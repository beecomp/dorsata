defmodule DorsataWeb.UserRoundLive.Index do
  use DorsataWeb, :live_view

  alias Dorsata.Competition
  alias Dorsata.Competition.UserRound

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users_rounds, Competition.list_users_rounds())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User round")
    |> assign(:user_round, Competition.get_user_round!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User round")
    |> assign(:user_round, %UserRound{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users rounds")
    |> assign(:user_round, nil)
  end

  @impl true
  def handle_info({DorsataWeb.UserRoundLive.FormComponent, {:saved, user_round}}, socket) do
    {:noreply, stream_insert(socket, :users_rounds, user_round)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_round = Competition.get_user_round!(id)
    {:ok, _} = Competition.delete_user_round(user_round)

    {:noreply, stream_delete(socket, :users_rounds, user_round)}
  end
end
