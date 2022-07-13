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

  # remove :atlas
  attr_accessor :atlas

  # Set the board with created piece objects
  def set_board
    rows = blank_board
    [7, 6, 1, 0].each do |num|
      rows[num].each_with_index do |cell, i|
        cell[:piece] = SET[num][1][i].new(cell[:pos], SET[num][0])
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
    transfer = @atlas.dup
    transfer = transfer.map do |row|
      row.map do |cell|
        cell.include?(:piece) ? cell[:piece].utf.chr(Encoding::UTF_8) : cell[:img]
      end
    end
    puts '   a b c d e f g'
    transfer.each_with_index { |row, i| puts "#{8 - i} #{row.join(' ')} #{8 - i}" }
    puts '   a b c d e f g'
  end

  # test_piece DELETE
  def test_piece
    @atlas[4][4][:piece] = Bishop.new([4, 4], 'w')
    @atlas[3][3][:piece] = Queen.new([3, 3], 'w')
  end

  # generates moves for each piece on call
  def moves
    @atlas.each do |row|
      row.each do |cell|
        # binding.pry
        next if cell[:piece].nil?

        if [Bishop, Rook, Queen].any? { |e| cell[:piece].instance_of?(e) }
          cell[:piece].moves = generate_moves(cell[:pos], cell[:piece].move_list)
        else
          cell[:piece].generate_moves
        end
      end
    end
  end

  def generate_moves(origin, queue, moves = [])
    queue.each do |trans|
      curr = origin
      loop do
        curr = [curr[0] + trans[0], curr[1] + trans [1]]
        break if curr.any? { |e| e.negative? || e > 7 }

        moves << curr

        break if piece_at(curr[0], curr[1])
      end
    end
    moves
  end

  def piece_at(row, column)
    atlas[row][column][:piece]
  end

# human to computer chess notation
def notation(string)
  coor = string.chars 
  l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
             'f' => 5, 'g' => 6, 'h' => 7 }
  [[8 - coor[1].to_i, l_hash[coor[0]]], [8 - coor[3].to_i, l_hash[coor[2]]]]
end

  def update(coor)
    coor = notation(coor)
    binding.pry
    start = @atlas[axis[0][0]][axis[1][1]]
  end
end

# def verify(move, player)
#   move = notation(move)
#   move = notation(gets.chomp) until origin_valid?(move, player) == true
#   move = notation(gets.chomp) until target_valid?(move) == true
# end

# def origin_valid?(loc, player)
#   origin = @atlas[loc[0][0]][loc[0][1]]
#   if origin[:piece].nil?
#     puts ERROR_EMPTY_SPACE
#     return false
#   elsif origin[:piece].color != player.color
#     puts ERROR_WRONG_PIECE
#     return false
#   end
#   true
# end

# def target_valid?(loc)
#   # binding.pry
#   piece = atlas[loc[0][0]][loc[0][1]][:piece]
#   transformation = [loc[1][0]-loc[0][0], loc[0][1] - loc[1][1]]
#   target = loc[1]
#   piece.moves.include?(transformation)
#   # unless piece.include?(loc)
#   #   puts "not a legal move"
#   #   return false
#   # end
#   # verify_check
# end

# # verify_check



# # create a new piece object and delete the old object
# def update(loc)
#   loc = notation(loc)
#   piece = atlas[loc[0][0]][loc[0][1]][:piece]
#   constr = [piece.class, piece.color]
#   # binding.pry
#   atlas[loc[1][0]][loc[1][1]][:piece] = constr[0].new(loc[1], constr[1])
#   @atlas[loc[0][0]][loc[0][1]].delete(:piece)
# end

hello = Board.new
hello.display
binding.pry
hello.test_piece
hello.moves
binding.pry

# hello.display