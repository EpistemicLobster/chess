require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

#contains additional information methods/constants
module Reference
  SET = { 0 => ['b', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]],
          1 => ['b', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          6 => ['w', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          7 => ['w', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]] }.freeze

  CHESS_NOTATION = { 0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e',
                     5 => 'f', 6 => 'g', 7 => 'h'}

  SET_NEW = { [7, 0] => [Rook, 'b'], [7, 1] => [Knight, 'b'],
              [7, 2] => [Bishop, 'b'], [7, 3] => [King, 'b'],
              [7, 4] =>  [Queen, 'b'], [7, 5] => [Bishop, 'b'],
              [7, 6] => [Knight, 'b'], [7, 7] => [Rook, 'b'],
              [6, 0] => [Pawn, 'b'], [6, 1] => [Pawn, 'b'],
              [6, 2] =>  [Pawn, 'b'], [6, 3] =>  [Pawn, 'b'],
              [6, 4] =>  [Pawn, 'b'], [6, 5] =>  [Pawn, 'b'],
              [6, 6] =>  [Pawn, 'b'], [6, 7] =>  [Pawn, 'b'],
              [0, 0] =>  [Rook, 'w'], [0, 1] => [Knight, 'w'],
              [0, 2] => [Bishop, 'w'], [0, 3] => [Queen, 'w'],
              [0, 4] => [King, 'w'], [0, 5] => [Bishop, 'w'],
              [0, 6] => [Knight, 'w'], [0, 7] => [Rook, 'w'],
              [1, 0] => [Pawn, 'w'], [1, 1] => [Pawn, 'w'],
              [1, 2] => [Pawn, 'w'], [1, 3] => [Pawn, 'w'],
              [1, 4] => [Pawn, 'w'], [1, 5] => [Pawn, 'w'],
              [1, 6] => [Pawn, 'w'], [1, 7] => [Pawn, 'w'] }.freeze

  # For board.rb piece creation
  PIECE = { Rook: Rook, Knight: Knight, Bishop: Bishop,
            King: King, Queen: Queen, Pawn: Pawn }.freeze

  MOVES = { Bishop => [[1, 1], [-1, 1], [-1, -1], [1, -1]],
            Rook => [[1, 0], [0, 1], [-1, 0], [0, -1]],
            Queen => [[1, 1], [-1, 1], [-1, -1], [1, -1],
                      [1, 0], [0, 1], [-1, 0], [0, -1]] }.freeze

end