# Menu methods
module Menu 
  def welcome_to_chess
    puts 'Welcome to chess!'
    puts 'Please choose an option from the menu to get started: '
    puts 'Main menu: '
  end

  def show_menu
    options = ['1. New Game' , '2. Load Game', '3. Exit']
    options.each { |msg| puts msg }
    go_to_option(choose_option)
  end

  def choose_option
    print 'option #: '
    loop do
      input = gets.chomp
      break input if input.match?(/[1-3]/)
    end
  end

  def go_to_option(input)
    case input
    when '1'
      main_loop
    when '2'
      load_game
    when '3'
      message_goodbye
    end
  end

  def message_goodbye
    puts 'Thanks for playing! Come back soon!'
    @game_over = true
  end
end