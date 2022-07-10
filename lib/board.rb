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

  attr_accessor :atlas

  # Sets the board at to initiate a new game
  def set_board
    # sets coordinates
    pos = Array.new(8) { |o| Array.new(8) { |i| [[o, i]] } }
    # sets square indicator
    pos.map! { |i| i.map { |c| c << (c[0].reduce(:+) % 2 == 0 ? ['♢'] : ['♦']) } }
    # creates and sets piece objects
    pos[7].map!.each_with_index { |c, i| c[1] << SET[:row_one][i].new(c[0], 'b') }
    pos[6].map!.each_with_index { |c, i| c[1] << SET[:row_two][i].new(c[0], 'b') }
    pos[1].map!.each_with_index { |c, i| c[1] << SET[:row_seven][i].new(c[0], 'w') }
    pos[0].map!.each_with_index { |c, i| c[1] << SET[:row_eight][i].new(c[0], 'w') }
    pos
  end

  def display
    # Set piece graphics in @atlas
    g = board_graphics(@atlas)


    puts <<~GUI
      a b c d e f g h
    8 #{g[0]} ♦ ♢ ♦ ♢ ♦ ♢ ♦ 8
    7 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 7
    6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
    5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
    4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
    3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
    2 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 2
    1 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 1
      a b c d e f g h
    GUI
    puts <<~GUI
      a b c d e f g h
    8 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 8
    7 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 7
    6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
    5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
    4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
    3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
    2 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 2
    1 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 1
      a b c d e f g h
    GUI

  end

  # human to computer chess notation
  def notation(letter, number)
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    @atlas[8 - number][l_hash[letter]]
  end
end

hello = Board.new
binding.pry

p hello.notation('d', 8)
