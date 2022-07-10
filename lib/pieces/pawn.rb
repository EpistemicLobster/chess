#Creates a chess pawn
class Pawn 
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9817 : 9823
    @moves = naive_moves
    @children = []
  end
  
  attr_accessor :utf

  FIRST_BLACK = [[2, 0], [1, 0]]
  STD_BLACK = [[1, 0], [1, 1], [1, -1]]
  FIRST_WHITE = [[-2, 0], [-1, 0]]
  STD_WHITE = [[-1, 0], [-1, -1], [1, -1]]
  
  def naive_moves
    if utf == 9817
      @location[0] == 5 ? FIRST_WHITE : STD_WHITE
    elsif utf == 9823
      @location[0] == 5 ? FIRST_BLACK : STD_BLACK
    end
  end

  # Updates moves and location// FROM BOARD ?
  def update_moves(new_location, board_state)
    @location = new_location
    @moves = legal_moves
  end
end