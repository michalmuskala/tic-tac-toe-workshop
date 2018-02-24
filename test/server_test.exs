defmodule TicTacToe.ServerTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Server

  test "we can start the server" do
    pid = Server.spawn()
    assert is_pid(pid)
  end

  test "we can move" do
    pid = Server.spawn()
    send(pid, {:move, 0, 0, self()})
    assert_receive :ok
  end

  test "we cannot move twice" do
    pid = Server.spawn()
    send(pid, {:move, 0, 0, self()})
    assert_receive :ok
    send(pid, {:move, 0, 0, self()})
    assert_receive :not_allowed
  end

  test "we can print!" do
    pid = Server.spawn()
    send(pid, {:print, self()})
    assert_receive {
      {:empty, :empty, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end

  test "player is changing" do
    pid = Server.spawn()
    send(pid, {:move, 0, 0, self()})
    assert_receive :ok
    send(pid, {:move, 0, 1, self()})
    assert_receive :ok
    send(pid, {:print, self()})
    assert_receive {
      {:x, :o, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end
end
