defmodule CounterWeb.CounterTest do
  use CounterWeb.ConnCase
  import Phoenix.LiveViewTest

  test "Increment", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    current = Counter.Count.current()
    assert html =~ "Counter: #{current}"
    assert render_click(view, :inc) =~ "Counter: #{current + 1}"
  end

  test "Decrement", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    current = Counter.Count.current()
    assert html =~ "Counter: #{current}"
    assert render_click(view, :dec) =~ "Counter: #{current - 1}"
  end

  test "handle_info/2 Count Update", %{conn: conn} do
    {:ok, view, disconnected_html} = live(conn, "/")
    current = Counter.Count.current()
    assert disconnected_html =~ "Counter: #{current}"
    assert render(view) =~ "Counter: #{current}"
    send(view.pid, {:count, 2})
    assert render(view) =~ "Counter: 2"
  end
end
