# Creates a chess pawn
class Pawn 
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9817 : 9823
    @moves = []
  end

  attr_reader :location, :color, :utf, :moves

  FIRST_BLACK = [[2, 0], [1, 0], [1, 1], [1, -1]].freeze
  STD_BLACK = [[1, 0], [1, 1], [1, -1]].freeze
  FIRST_WHITE = [[-2, 0], [-1, 0], [-1, -1], [-1, 1]].freeze
  STD_WHITE = [[-1, 0], [-1, -1], [-1, 1]].freeze

  def generate_moves
    @moves = hereditary_moves
    @moves = prune_moves
  end

  def hereditary_moves
    case @utf
    when 9817
      @location[0] == 6 ? FIRST_WHITE : STD_WHITE
    when 9823
      @location[0] == 1 ? FIRST_BLACK : STD_BLACK
    end
  end

  def prune_moves
    updated_moves = []
    @moves.map do |move|
      new_coord = [location[0] + move[0], location[1] + move[1]]
      updated_moves << new_coord unless new_coord.any? { |c| c.negative? || c > 7 }
    end
    @moves = updated_moves
  end

  # Updates moves and location// FROM BOARD ?
  def update_moves(new_location, board_state)
    @location = new_location
    @moves = legal_moves
  end
end