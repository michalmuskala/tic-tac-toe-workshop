defmodule TicTacToe.ServerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Server

  test "we can start the server" do
    pid = Server.spawn()
    assert is_pid(pid)
  end

  test "we don't leak processes" do
    test = self()
    starter = spawn(fn ->
      server = Server.spawn()
      send(test, server)
      :timer.sleep(:infinity)
    end)
    receive do
      server ->
        Process.exit(starter, :shutdown)
        :timer.sleep(100)
        refute Process.alive?(server)
    end
  end

  test "we can move" do
    pid = Server.spawn()
    assert Server.call(pid, {:move, 0, 0}) == :ok
  end

  test "we cannot move twice" do
    pid = Server.spawn()
    assert Server.call(pid, {:move, 0, 0}) == :ok
    assert Server.call(pid, {:move, 0, 0}) == :not_allowed
  end

  test "we can print!" do
    pid = Server.spawn()
    assert Server.call(pid, :print) == {
      {:empty, :empty, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end

  test "player is changing" do
    pid = Server.spawn()
    assert Server.call(pid, {:move, 0, 0}) == :ok
    assert Server.call(pid, {:move, 0, 1}) == :ok
    assert Server.call(pid, :print) == {
      {:x, :o, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end
end
