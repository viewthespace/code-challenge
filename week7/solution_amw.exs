# 2^n flips
defmodule Value do
  def inverse(0), do: 1
  def inverse(1), do: 0
end

defmodule Row do
  def shift(row, n) do
    Enum.drop(row, n) ++ Enum.take(row, n)
  end

  def is_row_uniform?(row), do: row |> Enum.dedup |> length == 1

  def to_columns(row) do
    Enum.map(row, fn n ->
      [n|[]]
    end)
  end
end

defmodule Column do
  def invert(column) do
    Enum.map(column, &(Value.inverse(&1)))
  end
end

defmodule Matrix do

  def flip_column(matrix) do
    Enum.map(matrix, &(flip_first_num(&1)))
  end

  def invert_column(matrix) do
    columns = transpose(matrix)
    [head|tail]= columns
    Column.invert()
  end

  def append_columns([], new_columns) do
    [] ++ new_columns
  end

  def append_columns(existing_columns, new_columns) do
    Enum.zip(existing_columns, new_columns)
    |> Enum.map(fn t -> elem(t, 0) ++ elem(t, 1) end)
  end

  # row:    [0, 1, 1, 0]
  # column: [[0], [1], [1], [0]]
  def transpose(matrix) do
    Enum.reduce(matrix, [], fn row, acc ->
      append_columns(acc, Row.to_columns(row))
    end)
  end

  def flip_first_num(row) do
    [head|tail] = row
    flipped = Matrix.inverse(head)
    [flipped|tail]
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
  def generate_indexes(n) do
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
      new_row = generate_row(row, 0, n, [])
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

# Matrix.flip_column(matrix) |> IO.inspect
#Matrix.num_same_rows(same_matrix) |> IO.inspect

# IO.inspect Matrix.shift([1, 2, 3, 4], 1)
# IO.inspect Matrix.shift([1, 2, 3, 4], 2)
# IO.inspect Matrix.shift([1, 2, 3, 4], 3)
# IO.inspect Matrix.shift([1, 2, 3, 4], 4)j

columns = Matrix.transpose(matrix)
orig = Matrix.transpose(columns)

IO.inspect(columns)
IO.inspect(orig)
