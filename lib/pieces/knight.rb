# Creates a knight
class Knight
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9816 : 9822
    @moves = []
  end

  attr_reader :location, :utf, :moves, :color

  MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze

  def generate_moves(origin, atlas)
    @moves = []
    norm_moves(origin)
    capture_moves(atlas)
    self
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
