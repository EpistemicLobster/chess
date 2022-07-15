require 'pry-byebug'
require_relative 'reference'
require_relative 'player/message'

# creates a chess board, with methods to display
class Board
  include Reference
  include Message
  def initialize
    @atlas = initiate_board
    @check = false
    @check_mate = false
  end

  # remove :atlas
  attr_reader :check, :check_mate
  attr_accessor :atlas

  def initiate_board
    @atlas = set_board
    generate_moves
    atlas
  end

  # Set the board with created piece objects
  def set_board
    board = blank_board
    SET_NEW.each_pair do |key, value|
      board[key][:piece] = value[0].new(value[1])
    end
    board
  end

  # def cell_to_notation(cell)
  #   dictionary = { 0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e',
  #                  5 => 'f', 6 => 'g', 7 => 'h'}
  #   "#{dictionary[cell[1]]}#{8 - cell[0]}".to_sym
  # end

  # Create a blank board template hash
  def blank_board
    coordinates = Array.new(8) { |o| Array.new(8) { |i| [o, i] } }
    board = {}
    coordinates.each do |row|
      row.each { |cell| board[cell] = {} }
    end
    board.each do |key, value|
      value[:icon] = key.reduce(:+).even? ? '♢' : '♦'
    end
    board
  end

  def display
    arr = Array.new(8) { |o| Array.new(8) { |i| [o, i] } }
    arr = arr.map do |row|
      row.map do |cell|
        if atlas[cell][:piece].nil?
          atlas[cell][:icon]
        else
          atlas[cell][:piece].utf.chr(Encoding::UTF_8)
        end
      end
    end
    puts '  a b c d e f g h'
    arr.each_with_index { |row, i| puts "#{8 - i} #{row.join(' ')} #{8 - i}" }
    puts '  a b c d e f g h'
  end

  def generate_moves
    @atlas.each do |key, value|
      # binding.pry
      # binding.pry unless atlas[[4, 0]][:piece].nil?
      next if value[:piece].nil?

      value[:piece].generate_moves(key, @atlas.dup)
    end
  end

  def origin?(origin, color)
    if @atlas.dig(origin, :piece).nil?
      puts ERROR_EMPTY_SPACE
      return false
    elsif @atlas.dig(origin, :piece).color != color
      puts ERROR_WRONG_PIECE
      return false
    end
    true
  end

  def target?(origin, target, color)
    if atlas.dig(origin, :piece).moves.none?(target)
      puts ERROR_PIECE_INVALID
      return false
    elsif check?(origin, target, color)
      @check_mate = check_mate?(origin, color)
      puts ERROR_PLAYER_IN_CHECK
      return false
    end
    true
  end

  def find_piece(class_name, color)
    @atlas.select do |_key, value|
      value[:piece].instance_of?(class_name) && value[:piece].color == color
    end
  end

  def check?(origin, target, color)
    # binding.pry
    make_move(origin, target)
    king_loc = find_piece(King, color).keys[0]
    boolean = @atlas.any? do |_key, value|
      next if value[:piece].nil?

      value[:piece].moves.include?(king_loc)
    end
    make_move(target, origin)
    boolean
  end

  def make_move(origin, target)
    piece_copy = @atlas.dig(origin, :piece)
    @atlas[origin].delete(:piece)
    @atlas[target][:piece] = piece_copy
    generate_moves
  end

  # untested
  def check_mate?(origin, color)
    @atlas.any? do |_key, value|
      next if value[:piece].nil? || value[:piece].color != color

      value[:piece].moves.any? do |move|
        !check?(origin, move)
      end
    end
  end
end


hello = Board.new
# hello.display
# hello.make_move([6, 0], [4, 0])
# hello.display
# hello.make_move([4, 0], [3, 0])
# hello.display
# hello.make_move([3, 0], [2, 0])
# hello.display
hello.check?([6, 0], [4, 0], 'w')
# hello.display
# binding.pry
# hello.display
# binding.pry
# p hello.target?([6, 0], [5, 0], 'w')
# binding.pry
# hello.display