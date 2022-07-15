# Creates a king
class King
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9812 : 9818
    @moves = []
  end

  attr_reader :color, :utf, :moves

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def generate_moves(origin, atlas)
    norm_moves(origin)
    capture_moves(atlas)
  end

  def norm_moves(origin)
    MOVES.each do |move|
      curr = [origin[0] + move[0], origin[1] + move[1]]
      @moves << curr if curr.all? { |coor| coor.between?(0, 7) }
    end
  end

  def capture_moves(atlas)
    @moves.keep_if do |move|
      if atlas.dig(move, :piece).nil?
        true
      else
        atlas.dig(move, :piece).color != color
      end
    end
  end
end
