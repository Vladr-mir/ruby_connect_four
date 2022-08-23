# frozen_string_literal: false

require 'colorize'

# Grid management
class Grid
  attr_accessor :grid

  def initialize(rows = 6, columns = 7)
    @grid = Array.new(rows) { Array.new(columns) }
  end

  def drop_object(obj, column)
    row_pointer = 0
    while row_pointer < @grid.length - 1
      break unless @grid[row_pointer + 1][column].nil?

      row_pointer += 1
    end
    @grid[row_pointer][column] = obj
  end

  def show
    @grid.each do |row|
      formatted_row = ''
      row.each do |square|
        formatted_row += square.nil? ? '◌' : square.to_s
        formatted_row += "\s"
      end
      puts formatted_row
    end
  end

  def find_pattern
    pattern = []
    pattern += each_row_pattern(@grid)
    pattern += each_row_pattern(@grid.transpose)
    pattern += each_row_pattern(find_diagonals(@grid))
    pattern += each_row_pattern(find_diagonals(@grid.reverse))
    pattern.compact!
    return pattern.first unless pattern.empty?
  end

  private

  def each_row_pattern(arr)
    pattern = []
    arr.each { |row| pattern << find_horizontal_pattern(row) }
    pattern
  end

  def find_horizontal_pattern(arr)
    return nil if arr.empty?

    counter = 0
    last = nil
    arr.each do |row|
      next if row.nil?

      last == row ? counter += 1 : counter = 0
      return row if counter >= 3

      last = row
    end
    nil
  end

  def find_diagonals(arr)
    return nil if arr.empty?

    size = arr.size - 1
    diagonals = []

    arr.each do |row|
      inverse_size = arr.size - size
      diagonals << (([nil] * inverse_size) + row + ([nil] * size))
      size -= 1
    end

    diagonals.transpose.map(&:compact).reject(&:empty?)
  end
end
