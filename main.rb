# frozen_string_literal: true

require './lib/game'
require './lib/validate'
require './lib/input'

def play_game?
  puts 'Would you like to play Hangman?'
  puts "(\e[32m y \e[0m/\e[31m n \e[0m)"
  user_input
  validate_input
end

play_game?
