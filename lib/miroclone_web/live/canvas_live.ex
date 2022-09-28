defmodule MiroCloneWeb.CanvasLive do
  use MiroCloneWeb, :live_view

  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_params, _session, socket) do
    temperature = 15

    Process.send_after(self(), :ping, 1000)

    socket = assign(socket, :page_title, "Hello world this is canvas")

    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_info(:ping, socket) do
    Process.send_after(self(), :ping, 1000)
    {:noreply, update(socket, :temperature, fn x -> x + 1 end)}
  end
end
