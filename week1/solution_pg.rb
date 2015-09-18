# Time: O(n) (good)
# Space: 3 bits for every filled square, plus Ruby overhead (not particularly great)
# Elegance: pretty freaking elegant

class SudokuSolver

  def initialize sudoku
    @sudoku = sudoku
  end

  def valid?
    begin
      check_sudoku
      true
    rescue => e
      false
    end
  end

  def check_sudoku
    (0..8).each do |index|
      check_square index
    end
  end

  def check_square index
    (0..2).each do |row|
      (0..2).each do |column|
        check_or_blow_up :square, index, @sudoku[row_number(index, row)][column_number(index, column)]
        check_or_blow_up :row, row_number(index, row), @sudoku[row_number(index, row)][column_number(index, column)]
        check_or_blow_up :column, column_number(index, column), @sudoku[row_number(index, row)][column_number(index, column)]
      end
    end
  end

  def column_number square_index, offset
    offset+((square_index%3)*3)
  end

  def row_number square_index, offset
    offset+((square_index/3)*3)
  end

  def check_or_blow_up type, index, digit
    return unless digit.present?
    if main_hash[type][index*10 + digit].present?
      raise "SUDOKU BAD"
    else
      main_hash[type][index*10 + digit] = true
    end
  end

  def main_hash
    @main_hash ||= { column: {}, row: {}, square: {} }
  end

end
