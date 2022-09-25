defmodule MiroClone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MiroClone.Repo,
      # Start the Telemetry supervisor
      MiroCloneWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MiroClone.PubSub},
      # Start the Endpoint (http/https)
      MiroCloneWeb.Endpoint
      # Start a worker by calling: MiroClone.Worker.start_link(arg)
      # {MiroClone.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MiroClone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MiroCloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
