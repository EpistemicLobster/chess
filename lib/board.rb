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

  attr_accessor :atlas, :check, :check_mate

  def display
    table = load_display_table
    puts '  a b c d e f g h'
    table.each_with_index { |row, i| puts "#{8 - i} #{row.join(' ')} #{8 - i}" }
    puts '  a b c d e f g h'
  end

  def make_move(origin, target)
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
    elsif moves_into_check?(origin, target, color)
      puts ERROR_PLAYER_IN_CHECK
      return false
    end
    true
  end

  # old check
  # def check?
  #   make_move(origin, target)
  #   king_loc = find_piece(King, color).keys[0]
  #   boolean = @atlas.any? do |_key, value|
  #     next if value[:piece].nil?

  #     value[:piece].moves.include?(king_loc)
  #   end
  #   make_move(target, origin)
  #   boolean
  # end

  def moves_into_check?
    make_move(origin, target)
    boolean = check?(color)
    make_move(target, origin)
    boolean
  end

  def check?(color)
    king_loc = find_piece(King, color).keys[0]
    @atlas.any? do |_key, value|
      next if value[:piece].nil?

      value[:piece].moves.include?(king_loc)
    end
  end

  def check_mate?(color)
    binding.pry
    @atlas.any? do |_key, value|
      next if value[:piece].nil? || value[:piece].color != color

      value[:piece].moves.any? do |move|
        !check?(color)
      end
    end
  end

  def game_end?(color)
    if check?(color) == false && check_mate?(color) ==
    end

  end

  # ORIGINAL
  # def check_mate?(origin, color)
  #   @atlas.any? do |_key, value|
  #     next if value[:piece].nil? || value[:piece].color != color

  #     value[:piece].moves.any? do |move|
  #       !check?(origin, move, color)
  #     end
  #   end
  # end


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
    coordinates.each do |row|
      row.each { |cell| board[cell] = {} }
    end
    board.each_pair do |key, value|
      value[:icon] = key.reduce(:+).even? ? '♢' : '♦'
    end
    board
  end

  def generate_moves
    @atlas.each do |key, value|
      next if value[:piece].nil?

      value[:piece].generate_moves(key, @atlas.dup)
    end
  end

  def load_display_table
    table = Array.new(8) { Array.new(8) }
    atlas.each do |key, value|
      table[key[0]][key[1]] = if value[:piece].nil?
                                value[:icon]
                              else
                                value[:piece].utf.chr(Encoding::UTF_8)
                              end
    end
    table
  end

  def find_piece(class_name, color)
    @atlas.select do |_key, value|
      value[:piece].instance_of?(class_name) && value[:piece].color == color
    end
  end



  # untested


end


hello = Board.new
hello.display
# hello.make_move([7, 3], [1, 5])
binding.pry
hello.display
p hello.check_mate?([7, 3], [1, 5], 'white')
# hello.make_move([4, 0], [3, 0])
# hello.display
# hello.make_move([3, 0], [2, 0])
# hello.display
# hello.check?([6, 0], [4, 0], 'w')
# hello.display
# binding.pry
# hello.display
# binding.pry
# p hello.target?([6, 0], [5, 0], 'w')
# binding.pry
# hello.display