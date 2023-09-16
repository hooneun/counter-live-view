defmodule CounterWeb.Counter do
  use CounterWeb, :live_view
  alias Counter.Count
  alias Phoenix.PubSub

  @topic Count.topic()

  def mount(_params, _session, socket) do
    PubSub.subscribe(Counter.PubSub, @topic)

    {:ok, assign(socket, val: Count.current())}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Counter: <%= @val %></h1>
      <.button phx-click="dec">-</.button>
      <.button phx-click="inc">+</.button>
    </div>
    """
  end
end
