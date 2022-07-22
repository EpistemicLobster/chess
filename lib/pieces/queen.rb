# frozen_string_literal: true

require_relative 'generic_piece'

# Creates a queen
class Queen < GenericPiece
  MOVES = [[1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def determine_standard_moves(origin, atlas)
    MOVES.each do |move|
      curr = origin
      loop do
        curr = [curr[0] + move[0], curr[1] + move[1]]
        break unless curr.all? { |coor| coor.between?(0, 7) }

        @moves << curr
        break if atlas[curr][:piece]
      end
    end
  end
end
