# frozen_string_literal: true

require './lib/game'
require 'pry'

@game = Game.new(0, '', [], [], 0)
@game.play_game?(@game, 'Would you like to play Hangman?')
