# frozen_string_literal: true

require './lib/game'
require 'pry'

@game = Game.new(0, '', [], [], 0)
if File.exist?('./output/saved_game.txt')
  @game.play_saved_game?
else
  @game.play_game?(@game, "Would you like to play Hangman? (\e[32m y \e[0m/\e[31m n \e[0m)")
end
