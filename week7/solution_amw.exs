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

  @doc """
  Entry point for the challenge. Sets up the following brute force pipeline:
    1) Generate all combinations of indexes of columns that should be flipped
    2) Create a list of matrices that are transformed according to each combination
    3) Check the number of uniform rows in each of the tranformed matrices
    4) Find the max of all of those
  """
  def khan_box(matrix) do
    length(matrix)
    |> Combinations.generate_flip_indexes
    |> all_transformations(matrix)
    |> Enum.map(fn matrix -> num_uniform_rows(matrix) end)
    |> Enum.max
  end

  @doc """
  Given an an list of lists of columns to flip, return a list
  of all transformed matrices by flipping the respective columns
  """
  def all_transformations(all_columns_to_flip, matrix) do
    Enum.map(all_columns_to_flip, fn columns_to_flip ->
      single_transformation(matrix, columns_to_flip)
    end)
  end

  @doc """
  Given an list of columns to flip, return a transformed matrix
  by flipping the given columns
  """
  def single_transformation(matrix, columns_to_flip) do
    transposed = transpose(matrix)
    Enum.reduce(columns_to_flip, transposed, fn flip_column, acc ->
      inverted = Enum.at(acc, flip_column) |> Row.invert
      List.replace_at(acc, flip_column, inverted)
    end)
    |> transpose
  end

  defp append_columns([], new_columns) do
    [] ++ new_columns
  end

  defp append_columns(existing_columns, new_columns) do
    Enum.zip(existing_columns, new_columns)
    |> Enum.map(fn t -> elem(t, 0) ++ elem(t, 1) end)
  end

  def transpose(matrix) do
    Enum.reduce(matrix, [], fn row, acc ->
      append_columns(acc, Row.to_columns(row))
    end)
  end

  defp num_uniform_rows(matrix) do
    Enum.reduce(matrix, 0, fn row, acc ->
      Row.is_row_uniform?(row) |> num_rows(acc)
    end)
  end

  defp num_rows(true, acc), do: acc + 1
  defp num_rows(false, acc), do: acc

end

defmodule Combinations do
  @doc """
  Generates a list of all combinations of columns that should be
  flipped such that all possible states of transformed matrices can
  be produced.

  n is the size of a square matrix.

  Returns a list where each element is a list of indexes that will
  produce one transformed matrix.

  Example:

  A 2 x 2 matrix can have 4 possible flip states (1 means flipped):

  0 0
  0 1
  1 0
  1 1

  For n = 2, this method will return:

  [[0, 1], [0], [1], []]

  Each of those elements signifies which column to flip for a given
  flip state.
  """
  def generate_flip_indexes(n) do
    generate_flip_states(n) |>
    Enum.map(fn c ->
      Enum.with_index(c)
      |> Enum.filter(fn c -> elem(c, 0) == 0 end)
      |> Enum.map(fn c -> elem(c, 1) end)
    end)
  end

  # Generates truth-table like input values corresponding
  # to all possible states of which columns are flipped, i.e.
  #
  # For a 2 x 2 matrix, it will generate:
  #
  # 0 0 => No columns flipped
  # 0 1 => Rightmost column flipped
  # 1 0 => Leftmost column flipped
  # 1 1 => Both columns flipped
  defp generate_flip_states(n) do
    num_rows = :math.pow(2, n) |> trunc
    Enum.map(0..num_rows-1, fn row ->
      bit_list_representation(row, 0, n, [])
    end)
  end

  defp bit_list_representation(_, n, n, acc), do: acc

  # Returns a list of bits corresponding to the binary representation
  # of the given curr_row
  defp bit_list_representation(curr_row, curr_col, n, acc) do
    result = curr_row / :math.pow(2, curr_col) |> trunc |> rem(2)
    bit_list_representation(curr_row, curr_col + 1, n, [result|acc])
  end
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

IO.inspect Enum.map([matrix, matrix2], fn matrix ->
  Matrix.khan_box(matrix)
end)
