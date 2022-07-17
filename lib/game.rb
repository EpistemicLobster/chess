require 'pry-byebug'
require_relative 'board'
require_relative 'player/player'

# Implement General Game Loop
class Game
  include Message
  def initialize
    @board = Board.new
    @player_one = Player.new(1, 'white')
    @player_two = Player.new(2, 'black')
    @current_player = @player_one
  end

  attr_accessor :board, :player_one

  def main_loop
    until @board.check_mate == true
      # player_in_check(@current_player) if @board.check == true
      @board.display
      make_move
      @current_player = @current_player == @player_one ? @player_two : @player_one
    end
    puts "CHECK MATE!!! AHAA "
  end

  def make_move
    puts "#{@current_player.name} please make a move: "
    move = verify
    @board.make_move(move[0], move[1])
  end

  def notation(string)
    coor = string.chars
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    [[8 - coor[1].to_i, l_hash[coor[0]]], [8 - coor[3].to_i, l_hash[coor[2]]]]
  end

  def verify
    a = nil
    b = nil
    c = @current_player.color
    loop do
      move = syntax_check(gets.chomp)
      a = notation(move)[0]
      b = notation(move)[1]
      break if @board.origin?(a, c) && @board.target?(a, b, c)
    end
    [a, b]
  end

  def syntax_check(move)
    until move.match?(/^[a-h][1-8][a-h][1-8]$/)
      puts "Input Error! \n" \
            "Use board notation to denote start & end positions.\n" \
            'Examples: a2b3, h4h3, c1c5... etc: '
      move = gets.chomp
    end
    move
  end
end


game = Game.new
game.main_loop
# game.board.make_move([6, 0], [4, 0])
# game.board.display
# game.board.make_move([4, 0], [3, 0])
# game.board.display
# game.board.make_move([3, 0], [2, 0])
# game.board.display