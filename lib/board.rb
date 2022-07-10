require 'pry-byebug'
require_relative 'reference'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# creates a chess board, with methods to display
class Board
  include Reference
  def initialize
    @atlas = set_board
  end

  # Set the board with created piece objects
  def set_board
    rows = blank_board
    [7, 6, 1, 0].each do |num|
      rows[num].each_with_index do |cell, idx|
        cell[:piece] = SET[num][1][idx].new(cell[:pos], SET[num][0])
      end
    end
    rows
  end

  # Create a blank board template array
  def blank_board
    rows = Array.new(8) { |o| Array.new(8) { |i| { pos: [o, i] } } }
    rows.map! do |row|
      row.each do |cell|
        cell[:img] = cell[:pos].reduce(:+).even? ? '♢' : '♦'
      end
    end
    rows
  end

  def display
    graphics = @atlas.dup
    graphics = graphics.map do |row|
      row.map do |cell|
        cell.include?(:piece) ? c[:piece].utf.chr(Encoding::UTF_8) : c[:img]
      end
    end
    puts %w[a b c d e f g h].join(' ').to_s
    graphics.each_with_index do |row, idx|
      puts "#{8 - idx} #{row.join(' ')} #{8 - idx}"
    end
    puts %w[a b c d e f g h].join(' ').to_s
  end
end

hello = Board.new
hello.display