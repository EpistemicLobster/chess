# Messages on command line interface // Instructions
module Message
  ERROR_EMPTY_SPACE = "Oh no! The starting space you selected is empty!\n" \
                      'Please try again: '.freeze
  ERROR_WRONG_PIECE = "Sorry, the piece you've selected is not yours!\n" \
                      'Please try again: '.freeze
  ERROR_SYNTAX = "Input Error! \n" \
                 "Use board notation to denote start & end positions.\n" \
                 'Examples: a2b3, h4h3, c1c5... etc: '.freeze
  ERROR_MOVE_INVALID = 'Sorry that move is invalid, please try again: '.freeze
  ERROR_PLAYER_IN_CHECK = "Sorry that move is invalid, your King is in check.\n" \
                          'Please try again: '.freeze

  def player_in_check(player)
    "#{player}, you are in check."
  end
end