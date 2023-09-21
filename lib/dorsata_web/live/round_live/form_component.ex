defmodule DorsataWeb.RoundLive.FormComponent do
  use DorsataWeb, :live_component

  alias Dorsata.Competition

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage round records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="round-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:shortname]} type="text" label="Shortname" />
        <.input field={@form[:problem_url]} type="text" label="Problem url" />
        <.input field={@form[:open_at]} type="datetime-local" label="Open at" />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(Dorsata.Competition.Round, :status)}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Round</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{round: round} = assigns, socket) do
    changeset = Competition.change_round(round)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"round" => round_params}, socket) do
    changeset =
      socket.assigns.round
      |> Competition.change_round(round_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"round" => round_params}, socket) do
    save_round(socket, socket.assigns.action, round_params)
  end

  defp save_round(socket, :edit, round_params) do
    case Competition.update_round(socket.assigns.round, round_params) do
      {:ok, round} ->
        notify_parent({:saved, round})

        {:noreply,
         socket
         |> put_flash(:info, "Round updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_round(socket, :new, round_params) do
    case Competition.create_round(round_params) do
      {:ok, round} ->
        notify_parent({:saved, round})

        {:noreply,
         socket
         |> put_flash(:info, "Round created successfully")
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
