# frozen_string_literal: true

require './lib/input'
require './lib/validate'
require './lib/dictionary'
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

  def play_game?(game_object)
    puts 'Would you like to play Hangman?'
    puts "(\e[32m y \e[0m/\e[31m n \e[0m)"
    validate_input(%w[y n]) == 'y' ? play_round(game_object) : exit_game
  end

  private

  def exit_game
    puts 'Goodbye'
  end

  def play_round(game_object)
    dictionary = Dictionary.new
    sample_word(dictionary)
    puts 'playing a round'
  end

  def sample_word(dictionary)
    @word = dictionary.dictionary.select do |element|
      element.length <= 12 && element.length >= 5
    end
    @word = @word.sample(1)
  end
end
