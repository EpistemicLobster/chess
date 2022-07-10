
# Empty Basic // Squares to default to
puts <<~GUI
a b c d e f g h
8 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 8
7 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 7
6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
2 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 2
1 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 1
a b c d e f g h
GUI

# Empty Frills
puts <<~GUI
⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊⚊
|                           |
|      a b c d e f g h      |
|    8 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 8    |
|    7 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 7    |
|    6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6    |
|    5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5    |
|    4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4    |
|    3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3    |
|    2 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 2    |
|    1 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 1    |
|      a b c d e f g h      |
|                           |
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    GUI
# Example Filled board
puts <<~GUI
  a b c d e f g h
8 ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 8
7 ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟ 7
6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
2 ♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙ 2
1 ♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 1
  a b c d e f g h
GUI


[["0, 0", "0, 1", "0, 2", "0, 3", "0, 4", "0, 5", "0, 6", "0, 7"],                 
 ["1, 0", "1, 1", "1, 2", "1, 3", "1, 4", "1, 5", "1, 6", "1, 7"],                 
 ["2, 0", "2, 1", "2, 2", "2, 3", "2, 4", "2, 5", "2, 6", "2, 7"],                 
 ["3, 0", "3, 1", "3, 2", "3, 3", "3, 4", "3, 5", "3, 6", "3, 7"],                 
 ["4, 0", "4, 1", "4, 2", "4, 3", "4, 4", "4, 5", "4, 6", "4, 7"],                 
 ["5, 0", "5, 1", "5, 2", "5, 3", "5, 4", "5, 5", "5, 6", "5, 7"],                 
 ["6, 0", "6, 1", "6, 2", "6, 3", "6, 4", "6, 5", "6, 6", "6, 7"],                 
 ["7, 0", "7, 1", "7, 2", "7, 3", "7, 4", "7, 5", "7, 6", "7, 7"]]      


   # Old set_board
  def set_board
    # sets coordinates
    pos = Array.new(8) { |o| Array.new(8) { |i| {coor: [o, i]} }  }

    # sets square indicator
    pos.map! { |i| i.map { |c| c << (c[0].reduce(:+) % 2 == 0 ? '♢' : '♦') } }
    # creates and sets piece objects
    pos[7].map!.each_with_index { |c, i| c[1] << SET[:row_one][i].new(c[0], 'b') }
    pos[6].map!.each_with_index { |c, i| c[1] << SET[:row_two][i].new(c[0], 'b') }
    pos[1].map!.each_with_index { |c, i| c[1] << SET[:row_seven][i].new(c[0], 'w') }
    pos[0].map!.each_with_index { |c, i| c[1] << SET[:row_eight][i].new(c[0], 'w') }
    pos
  end



  # human to computer chess notation
  def notation(letter, number)
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    @atlas[8 - number][l_hash[letter]]
  end