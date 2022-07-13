# Creates a king
class King
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9812 : 9818
    @moves = []
  end

  attr_reader :location, :color, :utf

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def generate_moves
    updated_moves = []
    MOVES.each do |move|
      new_coord = [location[0] + move[0], location[1] + move[1]]
      updated_moves << new_coord unless new_coord.any? { |c| c.negative? || c > 7 }
    end
    @moves = updated_moves
  end
end
