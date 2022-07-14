# Creates a rook
class Rook
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9814 : 9820
    @moves = []
  end

  attr_reader :utf, :color
  attr_accessor :moves

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def move_list
    MOVES
  end

  def generate_moves(origin, atlas, upd_moves = [])
    MOVES.each do |trans|
      curr = origin
      loop do
        curr = [curr[0] + trans[0], curr[1] + trans [1]]
        break if curr.any? { |e| e.negative? || e > 7 }

        upd_moves << curr

        break if atlas[curr][:piece]
      end
    end
    @moves = upd_moves
  end
end
