defmodule TicTacToe.Supervisor do
  @behaviour Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  def init(_) do
    children = [
      %{:id => 1, :start => {TicTacToe.GenServer, :start_link, [[{:name, :foo}]]}},
      %{:id => 2, :start => {TicTacToe.GenServer, :start_link, [[{:name, :bar}]]}}
    ]

    Supervisor.init(children, [{:strategy, :rest_for_one}])
  end
end
