defmodule DorsataWeb.UserRoundLive.FormComponent do
  use DorsataWeb, :live_component

  alias Dorsata.Competition

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_round records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_round-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <:actions>
          <.button phx-disable-with="Saving...">Save User round</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_round: user_round} = assigns, socket) do
    changeset = Competition.change_user_round(user_round)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_round" => user_round_params}, socket) do
    changeset =
      socket.assigns.user_round
      |> Competition.change_user_round(user_round_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_round" => user_round_params}, socket) do
    save_user_round(socket, socket.assigns.action, user_round_params)
  end

  defp save_user_round(socket, :edit, user_round_params) do
    case Competition.update_user_round(socket.assigns.user_round, user_round_params) do
      {:ok, user_round} ->
        notify_parent({:saved, user_round})

        {:noreply,
         socket
         |> put_flash(:info, "User round updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_round(socket, :new, user_round_params) do
    case Competition.create_user_round(user_round_params) do
      {:ok, user_round} ->
        notify_parent({:saved, user_round})

        {:noreply,
         socket
         |> put_flash(:info, "User round created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
