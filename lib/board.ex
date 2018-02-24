defmodule TicTacToe.Board do
  def new() do
    {
      {:empty, :empty, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end

  def move(board, x, y, player) do
    row = elem(board, x)
    if elem(row, y) == :empty do
      updated_row = put_elem(row, y, player)
      put_elem(board, x, updated_row)
    else
      :not_allowed
    end
  end

  # != -> ! =
  def find_winner({{p,p,p},_,_}) when p != :empty, do: p
  def find_winner({_,{p,p,p},_}) when p != :empty, do: p
  def find_winner({_,_,{p,p,p}}) when p != :empty, do: p
  def find_winner({{p,_,_},{p,_,_},{p,_,_}}) when p != :empty, do: p
  def find_winner({{_,p,_},{_,p,_},{_,p,_}}) when p != :empty, do: p
  def find_winner({{_,_,p},{_,_,p},{_,_,p}}) when p != :empty, do: p
  def find_winner({{p,_,_},{_,p,_},{_,_,p}}) when p != :empty, do: p
  def find_winner({{_,_,p},{_,p,_},{p,_,_}}) when p != :empty, do: p
  def find_winner(_), do: :no_winner

  def print({row1, row2, row3}) do
    "#{print_row(row1)}\n#{print_row(row2)}\n#{print_row(row3)}"
  end

  defp print_row({elem1, elem2, elem3}) do
    "#{stringify_element(elem1)}|#{stringify_element(elem2)}|#{stringify_element(elem3)}"
  end

  defp stringify_element(:empty), do: "   "
  defp stringify_element(:x), do: " x "
  defp stringify_element(:o), do: " o "
end
