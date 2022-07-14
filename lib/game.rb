require 'pry-byebug'
require_relative 'board'
require_relative 'player/player'
require_relative 'player/message'
# Game engine
# Implement Rules between pieces, capture, check, check-mate, invalid
# Implement General Game Loop
class Game
  include Message
  def initialize
    @board = Board.new
    @player_one = Player.new(1, 'w')
    @player_two = Player.new(2, 'b')
    @current_player = @player_one
  end

  attr_accessor :board, :player_one

  def loop
    make_move
  end

  def make_move
    puts 'Please make a move: '
    move = verify(gets.chomp)
    @board.update(move)
  end
  
  def move_generation

  end

  # def verify(move)
  #   until move.match?(/^[a-h][1-8][a-h][1-8]$/)
      
  #     move = gets.chomp
  #   end
  #   unless @board.origin_valid?(move, @current_player)
  #   @board.target_valid(move, @current_player)
  # end

  # def verify(move)
  #   syntax = syntax?(move)
  #   origin_valid = @board.origin_valid?(move, @current_player.color)
  #   target_valid = @board.target_valid?(move, @current_player.color)
  #   move = gets.chomp until syntax && origin_valid && target_valid
  # end



  # attempt to move all piece verification logic to game.rb


  def verify(move, a = move[0, 2], b = move[2, 3])
    # color = @current_player.color
    # binding.pry
    a = notation(a)
    b = notation(b)
    origin = @board.atlas.dig(a[0], a[1])
    target = @board.atlas.dig(b[0], b[1])
    c = @current_player.color
    until syntax?(move) && origin_valid?(origin, c) && target_valid?(origin, target, c)
      move = gets.chomp
      a = move[0, 2]
      b = move[2, 3]
    end
  end

  def notation(coor)
    letter = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    [8 - coor[1].to_i, letter[coor[0]]]
  end

  def origin_valid?(origin, color)
    # binding.pry
    piece = origin[:piece]
    if piece.nil?
      puts ERROR_EMPTY_SPACE
      return false
    elsif piece.color != color
      puts ERROR_WRONG_PIECE
      return false
    end
    p true
  end

  def target_valid?(origin, target, color)
    if origin[:piece].moves.none?(target[:pos])
      puts ERROR_PIECE_INVALID
      return false
    elsif !target[:piece].nil? && target[:piece].color == color
      puts ERROR_WRONG_PIECE
      return false
    elsif check?(color)
      return false
    end
    true
  end

  def check?(color)
    king = @board.find_piece(King, color)[:pos]
    @board.atlas.each do |row|
      row.each do |cell|
        next if cell[:piece].nil? || cell[:piece].color == colort

        if cell[:piece].moves.include?(king)
          puts ERROR_PLAYER_IN_CHECK
          return true
        end
      end
    end
    false
  end

  def syntax?(move)
    unless move.match?(/^[a-h][1-8][a-h][1-8]$/)
      puts "Input Error! \n" \
            "Use board notation to denote start & end positions.\n" \
            'Examples: a2b3, h4h3, c1c5... etc: '
      false
    end
    true
  end
end


game = Game.new
game.verify('a2a3')