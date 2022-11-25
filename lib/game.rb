# frozen_string_literal: true

require './lib/input'
require './lib/validate'
require 'pry'

# Game object
class Game
  include Input
  include Validate

  attr_accessor :round, :word, :guess, :guessed

  def initialize(round, word, guess, guessed)
    @round = round
    @word = word
    @guess = guess
    @guessed = guessed
  end

  def play_game?
    puts 'Would you like to play Hangman?'
    puts "(\e[32m y \e[0m/\e[31m n \e[0m)"
    validate_input(%w[y n]) == 'y' ? play_round : exit_game
  end

  private

  def play_round
    puts 'playing a round'
  end

  def exit_game
    puts 'Goodbye'
  end
end
