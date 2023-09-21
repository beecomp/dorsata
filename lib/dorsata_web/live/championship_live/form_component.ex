defmodule DorsataWeb.ChampionshipLive.FormComponent do
  use DorsataWeb, :live_component

  alias Dorsata.Competition

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage championship records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="championship-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:shortname]} type="text" label="Shortname" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Championship</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{championship: championship} = assigns, socket) do
    changeset = Competition.change_championship(championship)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"championship" => championship_params}, socket) do
    changeset =
      socket.assigns.championship
      |> Competition.change_championship(championship_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"championship" => championship_params}, socket) do
    save_championship(socket, socket.assigns.action, championship_params)
  end

  defp save_championship(socket, :edit, championship_params) do
    case Competition.update_championship(socket.assigns.championship, championship_params) do
      {:ok, championship} ->
        notify_parent({:saved, championship})

        {:noreply,
         socket
         |> put_flash(:info, "Championship updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_championship(socket, :new, championship_params) do
    case Competition.create_championship(championship_params) do
      {:ok, championship} ->
        notify_parent({:saved, championship})

        {:noreply,
         socket
         |> put_flash(:info, "Championship created successfully")
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
