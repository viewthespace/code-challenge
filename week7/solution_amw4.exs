defmodule Matrix do
  use Bitwise

  def khan_box(matrix) do
    columns = length(matrix)
    Enum.to_list(0..columns - 1)
    |> powerset
    |> Enum.map(&(flip_column_combination(matrix, &1)))
    |> Enum.map(&num_uniform_rows/1)
    |> Enum.max
  end

  def flip_column_combination(matrix, columns_to_flip) do
    Enum.map(matrix, fn row ->
      Enum.with_index(row) |> Enum.map(fn row_idx ->
        value_for(elem(row_idx, 0), elem(row_idx, 1) in columns_to_flip)
      end)
    end)
  end

  def value_for(v, true), do: bxor(v, 1)
  def value_for(v, false), do: v

  def num_uniform_rows(matrix) do
    Enum.filter(matrix, &is_row_uniform?/1) |> length
  end

  def is_row_uniform?(row), do: row |> Enum.dedup |> length == 1

  def powerset([]), do: [[]]
  def powerset([h|t]) do
    powerset_tail = powerset(t)
    (for n <- powerset_tail, do: [h|n]) ++ powerset_tail
  end

end

matrix =[
  [0, 1, 1, 0],
  [1, 1, 0, 0],
  [1, 0, 0, 1],
  [1, 0, 1, 1],
  [1, 0, 1, 1]
]

matrix2 = [
  [1, 1, 0],
  [0, 1, 1],
  [0, 1, 0]
]

IO.inspect Enum.map([matrix, matrix2], fn matrix ->
  Matrix.khan_box(matrix)
end)
