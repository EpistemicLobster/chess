# Creates a king
class King
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9812 : 9818
    @moves = []
  end

  attr_reader :color, :utf, :moves

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def generate_moves(origin, _atlas)
    updated_moves = []
    MOVES.each do |move|
      curr = [origin[0] + move[0], origin[1] + move[1]]
      updated_moves << curr unless curr.any? { |c| c.negative? || c > 7 }
    end
    @moves = updated_moves
  end
end
