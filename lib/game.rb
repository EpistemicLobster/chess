# Game engine
# Implement Rules between pieces, capture, check, check-mate, invalid
# Implement General Game Loop
class Game
  def initalize
    @board = Board.new
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
        - bad if check
    - if good => make_move
      - evaluates move
      - generates new piece at new position
      - 
=end