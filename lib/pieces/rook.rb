# Creates a rook
class Rook
  def initialize(color)
    @color = color
    @utf = color == 'white' ? 9814 : 9820
    @moves = []
  end

  attr_reader :utf, :color
  attr_accessor :moves

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def generate_moves(origin, atlas)
    @moves = []
    norm_moves(origin, atlas)
    capture_moves(atlas)
  end

  def norm_moves(origin, atlas)
    MOVES.each do |move|
      curr = origin
      loop do
        # binding.pry
        curr = [curr[0] + move[0], curr[1] + move[1]]
        break unless curr.all? { |coor| coor.between?(0, 7) }

        @moves << curr
        break if atlas[curr][:piece]
      end
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
