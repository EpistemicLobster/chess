require 'pry-byebug'
require_relative 'reference'
require_relative 'player/message'

# creates a chess board, with methods to display
class Board
  include Reference
  include Message
  def initialize
    @atlas = initiate_board
    
  end

  # remove :atlas
  attr_accessor :atlas

  def initiate_board
    @atlas = set_board
    moves
  end
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
    puts '  a b c d e f g h'
    transfer.each_with_index { |row, i| puts "#{8 - i} #{row.join(' ')} #{8 - i}" }
    puts '  a b c d e f g h'
  end

  def find_piece(target_class, color)
    item_row = @atlas.find do |row|
      row.find do |cell|
        cell[:piece].instance_of?(target_class) && cell[:piece].color == color
      end
    end
    item_row.find do |cell|
      cell[:piece].instance_of?(target_class) && cell[:piece].color == color
    end
  end

  # test_piece DELETE
  # def test_piece
  #   @atlas[4][4][:piece] = Bishop.new([4, 4], 'w')
  #   @atlas[3][3][:piece] = Queen.new([3, 3], 'w')
  # end

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

        break if piece_at(curr)
      end
    end
    moves
  end

  # def cell_at(loc)
  #   atlas[loc[0]][loc[1]]
  # end

  def piece_at(loc)
    atlas[loc[0]][loc[1]][:piece]
  end

  def origin_valid?(move, color)
    loc = notation(move)
    origin = piece_at(loc[0])
    if origin.nil?
      puts ERROR_EMPTY_SPACE
      return false
    elsif origin.color != color
      puts ERROR_WRONG_PIECE
      return false
    end
    true
  end

  # consider reworking
  def target_valid?(move, color)
    binding.pry
    loc = notation(move)
    if piece_at(loc[0]).moves.none?(loc[1]) || piece_at(loc[1]).color == color
      puts ERROR_PIECE_INVALID
      return false
    elsif check?(color)
      puts ERROR_PLAYER_IN_CHECK
      return false
    end
    true
  end

  # consider reworking
  # def target_valid(origin, target, color)
  #   if origin[:piece].moves.none?(target)
  #     puts ERROR_PIECE_INVALID
  #     false
  #   elsif target[:piece].color == color
  #     puts PLAYER_INVALID_MOVE
  #     false
  #   elsif check?(player.color)
  #     puts PLAYER_IN_CHECK
  #     false
  #   end
  #   true
  # end

  def check?(color)
    king = @atlas.find_piece(King, color).location
    @atlas.each do |row|
      row.each do |cell|
        next if cell[:piece].nil? || cell[:piece].color == color

        return true if cell[:piece].moves.include?(king)
      end
    end
  end

  def check_mate?(king)
    king.moves.each
  end


  # human to computer chess notation
  def notation(string)
    coor = string.chars
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    [[8 - coor[1].to_i, l_hash[coor[0]]], [8 - coor[3].to_i, l_hash[coor[2]]]]
  end

  def update(coor)
    coor = notatwion(coor)
    binding.pry
    start = @atlas[axis[0][0]][axis[1][1]]
  end
end

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
# hello.test_piece
# # test origin
# hello.moves
# hello.origin_valid?('a2a3', 'w')
# # test target
# hello.target_valid?('b2b3', 'w')
# binding.pry

# hello.display