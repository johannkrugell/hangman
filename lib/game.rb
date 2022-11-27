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

  def play_game?(game_object, prompt)
    game_title
    puts prompt
    puts "(\e[32m y \e[0m/\e[31m n \e[0m)"
    validate_input(%w[y n]) == 'y' ? play_round(game_object) : exit_game
  end

  private

  def check_winner
    puts 'You win!' if @word.join.split(//).eql?(@guess)
    @game = Game.new(0, '', [], [])
    @game.play_game?(@game, 'Would you like to play again?')
  end

  def empty_guess_array
    @word.join.length.times do
      @guess << ' _ '
    end
  end

  def exit_game
    puts 'Goodbye'
  end

  def guess_letter(game_object)
    if @guess.empty?
      empty_guess_array
      update_display(game_object, 'Please enter a letter')
    else
      validate_input(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z])
      update_guess(game_object, @response.upcase)
      @guessed << @response.upcase
    end
  end

  def play_round(game_object)
    dictionary = Dictionary.new
    sample_word(dictionary)
    @round = 0
    while round <= @word.join.split(//).uniq.length
      guess_letter(game_object)
      update_display(game_object, 'Please enter a letter')
      @round += 1
    end
    check_winner
  end

  def sample_word(dictionary)
    @word = dictionary.dictionary.select do |element|
      element.length <= 12 && element.length >= 5
    end
    @word = @word.sample(1)
  end

  def update_guess(_game_object, _response)
    @word.join.split(//).each_with_index do |letter, index|
      @guess[index] = @response if letter == @response
    end
  end
end
