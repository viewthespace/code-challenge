# 2^n flips
defmodule Value do
  def inverse(0), do: 1
  def inverse(1), do: 0
end

defmodule Row do
  def is_row_uniform?(row), do: row |> Enum.dedup |> length == 1

  def invert(column) do
    Enum.map(column, &(Value.inverse(&1)))
  end

  def to_columns(row) do
    Enum.map(row, fn n ->
      [n|[]]
    end)
  end
end

defmodule Matrix do

  def all_transformations(all_columns_to_flip, matrix) do
    Enum.map(all_columns_to_flip, fn columns_to_flip ->
      single_transformation(matrix, columns_to_flip)
    end)
  end

  def single_transformation(matrix, columns_to_flip) do
    transposed = transpose(matrix)
    Enum.reduce(columns_to_flip, transposed, fn flip_column, acc ->
      row = Enum.at(acc, flip_column)
      inverted = Row.invert(row)
      List.replace_at(acc, flip_column, inverted)
    end)
    |> transpose
  end

  def append_columns([], new_columns) do
    [] ++ new_columns
  end

  def append_columns(existing_columns, new_columns) do
    Enum.zip(existing_columns, new_columns)
    |> Enum.map(fn t -> elem(t, 0) ++ elem(t, 1) end)
  end

  def transpose(matrix) do
    Enum.reduce(matrix, [], fn row, acc ->
      append_columns(acc, Row.to_columns(row))
    end)
  end

  def num_same_rows(matrix) do
    Enum.reduce(matrix, 0, fn row, acc ->
      Row.is_row_uniform?(row) |> num_rows(acc)
    end)
  end

  def num_rows(true, acc), do: acc + 1
  def num_rows(false, acc), do: acc

end

defmodule Combinations do
  def generate_flip_indexes(n) do
    combs = truth_table(n)
    indexes = Enum.map(combs, fn c ->
      Enum.with_index(c)
      |> Enum.filter(fn c -> elem(c, 0) == 0 end)
      |> Enum.map(fn c -> elem(c, 1) end)
    end)
  end

  def truth_table(n) do
    num_rows = :math.pow(2, n) |> trunc
    Enum.map(0..num_rows-1, fn row ->
      generate_row(row, 0, n, [])
    end)
  end

  defp generate_row(_, n, n, acc), do: acc

  defp generate_row(curr_row, curr_col, n, acc) do
    result = curr_row / :math.pow(2, curr_col) |> trunc |> rem(2)
    generate_row(curr_row, curr_col + 1, n, [result|acc])
  end
end

matrix =[
  [0, 1, 1, 0],
  [1, 1, 0, 0],
  [1, 0, 0, 1],
  [1, 0, 1, 1]
]

same_matrix = [
  [0, 0, 0, 0],
  [1, 1, 1, 1],
  [0, 1, 0, 1]
]

matrix2 = [
  [1, 1, 0],
  [0, 1, 1],
  [0, 1, 0]
]

#IO.inspect Matrix.single_transformation(matrix, [2, 3])

IO.inspect length(matrix2)
|> Combinations.generate_flip_indexes
|> Matrix.all_transformations(matrix2)
|> Enum.map(fn matrix -> Matrix.num_same_rows(matrix) end)
|> Enum.max
