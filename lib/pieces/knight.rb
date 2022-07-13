# Creates a knight
class Knight
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9816 : 9822
    @moves = []
  end

  attr_reader :location, :color, :utf

  MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

  def generate_moves
    updated_moves = []
    MOVES.each do |move|
      new_coord = [location[0] + move[0], location[1] + move[1]]
      updated_moves << new_coord unless new_coord.any? { |c| c.negative? || c > 7 }
    end
    @moves = updated_moves
  end
end
