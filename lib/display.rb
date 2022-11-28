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

  def update_display(game_object, prompt)
    clear_display
    puts "\e[31mGuess:\e[0m #{@round}  \e[34mWord: #{game_object.guess.join.upcase}\e[0m"
    puts ''
    puts "You guessed: #{game_object.guessed.join(', ')}"
    puts ''
    puts prompt
    display_tree
    display_apples
  end

  def line_number
    Random.new.rand(8..12)
  end

  def column_number
    Random.new.rand(5..23)
  end

  def display_apples
    number_of_apples = @word.join.split(//).uniq.length - @incorrect_guess
    Array.new(number_of_apples, 'a').each do
      $stdout.write "\e[#{line_number};#{column_number}H"
      $stdout.write '🍎'
    end
  end

  def display_tree
    puts "
v .   ._, |_  .,
`-._\/  .  \ /    |/_
   \\  _\, y | \//--\/
_\_.___\\, \\/ -.\||/--
`7-,--.`._||  / / ,/'
/'     `-. `./ / |/_.'
          |    |//
          |_    /
          |-   |
          |   =|
          |    |
---------------------------"
  end
end
