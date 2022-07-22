# frozen_string_literal: true

require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../pieces/queen'
require_relative '../pieces/king'

# contains additional information methods/constants
module Reference
  SET = { 0 => ['b', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]],
          1 => ['b', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          6 => ['w', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          7 => ['w', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]] }.freeze

  SET_NEW = { [7, 0] => [Rook, 'white'], [7, 1] => [Knight, 'white'],
              [7, 2] => [Bishop, 'white'], [7, 3] => [Queen, 'white'],
              [7, 4] => [King, 'white'], [7, 5] => [Bishop, 'white'],
              [7, 6] => [Knight, 'white'], [7, 7] => [Rook, 'white'],
              [6, 0] => [Pawn, 'white'], [6, 1] => [Pawn, 'white'],
              [6, 2] => [Pawn, 'white'], [6, 3] =>  [Pawn, 'white'],
              [6, 4] => [Pawn, 'white'], [6, 5] =>  [Pawn, 'white'],
              [6, 6] => [Pawn, 'white'], [6, 7] =>  [Pawn, 'white'],
              [0, 0] => [Rook, 'black'], [0, 1] => [Knight, 'black'],
              [0, 2] => [Bishop, 'black'], [0, 3] => [Queen, 'black'],
              [0, 4] => [King, 'black'], [0, 5] => [Bishop, 'black'],
              [0, 6] => [Knight, 'black'], [0, 7] => [Rook, 'black'],
              [1, 0] => [Pawn, 'black'], [1, 1] => [Pawn, 'black'],
              [1, 2] => [Pawn, 'black'], [1, 3] => [Pawn, 'black'],
              [1, 4] => [Pawn, 'black'], [1, 5] => [Pawn, 'black'],
              [1, 6] => [Pawn, 'black'], [1, 7] => [Pawn, 'black'] }.freeze

end