require 'pry-byebug'
require_relative 'reference'
require_relative 'message'

# creates a chess board, with methods to display
class Board
  include Reference
  include Message
  def initialize
    @atlas = initiate_board
  end

  attr_accessor :atlas

  def display
    table = Array.new(8) { Array.new(8) }
    load_display_table(table)
    puts '  a b c d e f g h'
    table.each_with_index { |row, i| puts "#{8 - i} #{row.join(' ')} #{8 - i}" }
    puts '  a b c d e f g h'
  end

  def make_move(origin, target)
    # binding.pry
    piece_copy = @atlas.dig(origin, :piece)
    @atlas[origin].delete(:piece)
    @atlas[target][:piece] = piece_copy
    generate_moves
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
    if @atlas.dig(origin, :piece).moves.none?(target)
      puts ERROR_MOVE_INVALID
      return false
    elsif pseudo_move(origin, target) { check?(color) }
      puts ERROR_PLAYER_IN_CHECK
      return false
    end
    true
  end

  def check?(color)
    king_loc = find_piece(King, color).keys[0]
    @atlas.any? do |_key, value|
      next if value[:piece].nil?

      value[:piece].moves.include?(king_loc)
    end
  end

  def check_mate?(color)
    @atlas.any? do |key, value|
      next if value[:piece].nil? || value[:piece].color != color

      value[:piece].moves.any? do |move|
        pseudo_move(key, move) { check?(color) }
      end
    end
  end

  private

  def initiate_board
    @atlas = set_board
    generate_moves
    @atlas
  end

  # Set the board with created piece objects
  def set_board
    board = blank_board
    SET_NEW.each_pair do |key, value|
      board[key][:piece] = value[0].new(value[1])
    end
    board
  end

  # Create a blank board template hash
  def blank_board
    coordinates = Array.new(8) { |o| Array.new(8) { |i| [o, i] } }
    board = {}
    coordinates.each { |row| row.each { |cell| board[cell] = {} } }
    board.each_pair do |key, value|
      value[:icon] = key.reduce(:+).even? ? '♢' : '♦'
    end
    board
  end

  def pseudo_move(origin, target)
    make_move(origin, target)
    boolean = yield if block_given?
    make_move(target, origin)
    boolean
  end

  def generate_moves
    @atlas.each do |key, value|
      next if value[:piece].nil?

      value[:piece].generate_moves(key, @atlas.dup)
    end
  end

  def load_display_table(table)
    atlas.each do |key, value|
      next table[key[0]][key[1]] = value[:icon] if value[:piece].nil?

      table[key[0]][key[1]] = value[:piece].utf.chr(Encoding::UTF_8)
    end
  end

  def find_piece(class_name, color)
    @atlas.select do |_key, value|
      value[:piece].instance_of?(class_name) && value[:piece].color == color
    end
  end
end


hello = Board.new
hello.display
hello.pseudo_move([6, 6], [4, 6])
hello.display
hello.pseudo_move([6, 5], [4, 5])
hello.display
hello.pseudo_move([6, 4], [4, 4])
hello.display
hello.pseudo_move([6, 3], [4, 3])
hello.display