# frozen_string_literal: true

# helper module to update the terminal display
module Display
  def clear_display
    puts "\e[H\e[2J"
  end

  def game_title
    puts "
    \e[31m
    __   __  _______  __    _  _______  __   __  _______  __    _
    |  | |  ||   _   ||  |  | ||       ||  |_|  ||   _   ||  |  | |
    |  |_|  ||  |_|  ||   |_| ||    ___||       ||  |_|  ||   |_| |
    |       ||       ||       ||   | __ |       ||       ||       |
    |       ||       ||  _    ||   ||  ||       ||       ||  _    |
    |   _   ||   _   || | |   ||   |_| || ||_|| ||   _   || | |   |
    |__| |__||__| |__||_|  |__||_______||_|   |_||__| |__||_|  |__|
    \e[0m"
  end

  def update_terminal(game_object)
    clear_display
    puts game_object.guess.join
    puts 'Please enter your a letter'
  end
end
