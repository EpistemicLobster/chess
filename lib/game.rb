require 'pry-byebug'
require_relative 'board'
require_relative 'player/player'
# Game engine
# Implement Rules between pieces, capture, check, check-mate, invalid
# Implement General Game Loop
class Game
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
    binding.pry
    puts 'Please make a move: '
    move = verify(gets.chomp)
    @board.update(move)
  end

  def verify(move)
    move
  end
end

=begin 
- Pawn Make Move
  - Generate legal_moves for position
    - generate a tree
  - Request input from player
  - Verify input from player and return error if bad
    - if bad => return error
        - bad if not in  move list
        - bad if collision
          - check input if @atlas has piece and whose piece
          - if enemy piece => initate capture_method
        - bad if check
    - if good => make_move
      - evaluates move
      - generates new piece at new position
      - 
=end

game = Game.new
binding.pry
game.loop