defmodule Matrix do
  use Bitwise

  def khan_box(matrix) do
    length(matrix)
    |> Combinations.generate_flip_indexes
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
      Row.is_row_uniform?(row) |> num_rows(acc)
    end)
  end

  def is_row_uniform?(row), do: row |> Enum.dedup |> length == 1

  defp num_rows(true, acc), do: acc + 1
  defp num_rows(false, acc), do: acc

end

defmodule Combinations do
  def generate_flip_indexes(n) do
    generate_flip_states(n) |>
    Enum.map(fn c ->
      Enum.with_index(c)
      |> Enum.filter(fn c -> elem(c, 0) == 0 end)
      |> Enum.map(fn c -> elem(c, 1) end)
    end)
  end

  def generate_flip_states(n) do
    num_rows = :math.pow(2, n) |> trunc
    Enum.map(0..num_rows-1, fn row ->
      bit_list_representation(row, n)
    end)
  end

  def bit_list_representation(n, bits) do
    bit_list_representation(n, 0, bits, [])
  end

  def bit_list_representation(_, n, n, acc), do: acc

  def bit_list_representation(curr_row, curr_col, n, acc) do
    result = curr_row / :math.pow(2, curr_col) |> trunc |> rem(2)
    bit_list_representation(curr_row, curr_col + 1, n, [result|acc])
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

big = [
  [0, 1, 1, 0, 0, 1, 1, 0],
  [0, 1, 1, 0, 0, 1, 1, 0],
  [0, 1, 0, 0, 0, 1, 1, 0],
  [0, 1, 1, 0, 1, 1, 1, 0],
  [0, 1, 1, 0, 0, 1, 1, 0],
  [0, 1, 1, 0, 0, 1, 1, 0],
  [0, 1, 1, 0, 1, 1, 0, 0],
  [0, 1, 1, 0, 0, 1, 1, 0]
]

IO.inspect Enum.map([matrix, matrix2, big], fn matrix ->
  Matrix.khan_box(matrix)
end)
