#Creates a chess pawn
class Pawn 
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9817 : 9823
    @moves = []
    # @moves = generate_moves(location)
    @children = []
  end

  MOVE_STD = [-1, 1]
  MOVE_FIRST = [[-1, 1], [-2, 0]]
  CAP_MOVE = [[-1, -1], [1, -1]]
  

  def legal_moves
    moves = std_move = [-1, 0]
    if @location[0] == 5
      moves = MOVE_FIRST
    end
  end

  # Updates moves and location// FROM BOARD ?
  def update_moves(new_location, board_state)
    @location = new_location
    @moves = legal_moves
  end
end