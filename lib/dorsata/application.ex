defmodule Dorsata.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DorsataWeb.Telemetry,
      # Start the Ecto repository
      Dorsata.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dorsata.PubSub},
      # Start Finch
      {Finch, name: Dorsata.Finch},
      # Start the Endpoint (http/https)
      DorsataWeb.Endpoint
      # Start a worker by calling: Dorsata.Worker.start_link(arg)
      # {Dorsata.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dorsata.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DorsataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
