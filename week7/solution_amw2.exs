defmodule KhanBox do
  use Bitwise

  def khan_box(matrix) do
    Enum.reduce(matrix, %{}, fn(row, counter) ->
      key = row_key(row)
      update_counter(key, Map.get(counter, key), counter)
    end)
    |> Map.values
    |> Enum.max
  end

  def update_counter(k, nil, counter), do: Map.put(counter, k, 1)
  def update_counter(k, v, counter), do: %{counter | k => v + 1}

  def row_key(row) when hd(row) == 0, do: Enum.join(row)
  def row_key(row), do: Enum.map(row, &(bxor(&1, 1))) |> Enum.join
end

matrix =[
  [0, 1, 1, 0],
  [1, 1, 0, 0],
  [1, 0, 0, 1],
  [1, 0, 1, 1]
]

matrix2 = [
  [1, 1, 0],
  [0, 1, 1],
  [0, 1, 0]
]

IO.inspect [matrix, matrix2] |> Enum.map(fn(matrix) ->
  KhanBox.khan_box(matrix)
end)
