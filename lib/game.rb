# frozen_string_literal: true

require './lib/input'
require './lib/validate'
require './lib/dictionary'
require './lib/display'
require './lib/file'
require 'pry'

# Game object
class Game
  include Input
  include Validate
  include Display

  attr_accessor :round, :word, :guess, :guessed, :incorrect_guess

  def initialize(round, word, guess, guessed, incorrect_guess)
    @round = round
    @word = word
    @guess = guess
    @guessed = guessed
    @incorrect_guess = incorrect_guess
  end

  def play_game?(game_object, prompt)
    game_title
    puts prompt
    validate_input(%w[y n]) == 'y' ? play_round(game_object) : exit_game
  end

  def play_saved_game?
    game_title
    puts "Would you like to load a saved game? (\e[32m y \e[0m/\e[31m n \e[0m)"
    if validate_input(%w[y n]) == 'y'
      load_saved_game
    else
      clear_display
      @game = Game.new(0, '', [], [], 0)
      prompt = "Would you like to play Hangman? (\e[32m y \e[0m/\e[31m n \e[0m)"
      @game.play_game?(@game, prompt)
    end
  end

  private

  def check_winner
    clear_display
    puts 'You win!' if @word.join.split(//).eql?(@guess)
    puts "The word was: #{@word.join}"
    @game = Game.new(0, '', [], [], 0)
    @game.play_game?(@game, 'Would you like to play again?')
  end

  def empty_guess_array(game_object)
    @word.join.length.times do
      @guess << ' _ '
    end
    update_display(game_object, 'Please enter a letter', "\e[5;24H")
  end

  def exit_game
    puts 'Goodbye'
  end

  def game_setup(game_object)
    @word = game_object.word
    @round = game_object.round
    @incorrect_guess = game_object.incorrect_guess
    @guessed = game_object.guessed
    @guess = game_object.guess
  end

  def guess_letter(game_object)
    empty_guess_array(game_object) if @guess.empty?
    validate_input(%w[a b c d e f g h i j k l m n o p q r s t u v w x y z])
    update_guess(game_object, @response.upcase)
    update_incorrect_response(game_object, @response)
    @guessed << @response.upcase
  end

  def load_saved_game
    @saved_game = File.to_object
    play_round(@saved_game)
  end

  def play_round(game_object)
    game_object.word.empty? ? sample_word : game_setup(game_object)
    while @round < @word.join.split(//).uniq.length
      save_game?(game_object)
      update_display(game_object, 'Please enter a letter:', "\e[5;24H")
      guess_letter(game_object)
      update_display(game_object, '', "\e[6;1H")
      @round += 1
      sleep(5)
    end
    check_winner
  end

  def sample_word
    dictionary = Dictionary.new
    @word = dictionary.dictionary.select do |element|
      element.length <= 12 && element.length >= 5
    end
    @word = @word.sample(1)
  end

  def save_game?(game_object)
    if @round != 0
      update_display(game_object, '', "\e[5;1H")
      puts "Would you like to save the game? (\e[32m y \e[0m/\e[31m n \e[0m)"
      $stdout.write "\e[5;44H"
      File.to_hash(game_object) if validate_input(%w[y n]) == 'y'
      exit_game
    end
    clear_display
  end

  def update_incorrect_response(_game_object, _response)
    @word.any?(/#{@response}/) ? @incorrect_guess += 0 : @incorrect_guess += 1
  end

  def update_guess(_game_object, _response)
    @word.join.split(//).each_with_index do |letter, index|
      @guess[index] = @response if letter == @response
    end
  end
end
