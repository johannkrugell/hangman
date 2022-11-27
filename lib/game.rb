# frozen_string_literal: true

require './lib/input'
require './lib/validate'
require './lib/dictionary'
require './lib/display'
require 'pry'

# Game object
class Game
  include Input
  include Validate
  include Display

  attr_accessor :round, :word, :guess, :guessed

  def initialize(round, word, guess, guessed)
    @round = round
    @word = word
    @guess = guess
    @guessed = guessed
  end

  def play_game?(game_object)
    game_title
    puts 'Would you like to play Hangman?'
    puts "(\e[32m y \e[0m/\e[31m n \e[0m)"
    validate_input(%w[y n]) == 'y' ? play_round(game_object) : exit_game
  end

  private

  def exit_game
    puts 'Goodbye'
  end

  def guess_letter(game_object)
    @word.join.length.times do
      @guess << ' _ '
    end
    update_terminal(game_object)
    validate_input(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z])
    @guessed << @response
  end

  def play_round(game_object)
    dictionary = Dictionary.new
    sample_word(dictionary)
    guess_letter(game_object)
  end

  def sample_word(dictionary)
    @word = dictionary.dictionary.select do |element|
      element.length <= 12 && element.length >= 5
    end
    @word = @word.sample(1)
  end
end
