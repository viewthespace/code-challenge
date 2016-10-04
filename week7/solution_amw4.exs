defmodule Matrix do
  use Bitwise

  def khan_box(matrix) do
    columns = length(matrix)
    Enum.to_list(0..columns - 1)
    |> powerset
    |> all_transformations(matrix)
    |> Enum.map(fn matrix -> num_uniform_rows(matrix) end)
    |> Enum.max
  end

  def all_transformations(flip_indexes, matrix) do
    Enum.map(flip_indexes, &(single_transformation(matrix, &1)))
  end

  def single_transformation(matrix, columns_to_flip) do
    Enum.map(matrix, fn row ->
      Enum.with_index(row) |> Enum.map(fn row_idx ->
        value_for(elem(row_idx, 0), elem(row_idx, 1) in columns_to_flip)
      end)
    end)
  end

  def value_for(v, true), do: bxor(v, 1)
  def value_for(v, false), do: v

  defp num_uniform_rows(matrix) do
    Enum.reduce(matrix, 0, fn row, acc ->
      is_row_uniform?(row) |> num_rows(acc)
    end)
  end

  def is_row_uniform?(row), do: row |> Enum.dedup |> length == 1

  defp num_rows(true, acc), do: acc + 1
  defp num_rows(false, acc), do: acc

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
