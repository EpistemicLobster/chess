# Creates a knight
class Knight
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9816 : 9822
    @moves = []
  end

  attr_reader :location, :utf, :moves

  MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

  def generate_moves(origin, _atlas)
    updated_moves = []
    MOVES.each do |move|
      new_coord = [origin[0] + move[0], origin[1] + move[1]]
      updated_moves << new_coord unless new_coord.any? { |c| c.negative? || c > 7 }
    end
    @moves = updated_moves
  end
end
