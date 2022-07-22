# frozen_string_literal: true

require_relative 'generic_piece'

# Creates a knight
class Knight < GenericPiece
  MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze
end
