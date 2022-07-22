# frozen_string_literal: true

require_relative 'generic_piece'
# Creates a king
class King < GenericPiece
  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze
end
