# frozen_string_literal: true

# Game object
class Game
  attr_accessor :round, :word, :guess, :guessed

  def initialize(round, word, guess, guessed)
    @round = round
    @word = word
    @guess = guess
    @guessed = guessed
  end
end
