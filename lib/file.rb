# frozen_string_literal: true

require 'json'
require 'pry'

# help module to serialize game object and save as file
class File
  def self.to_json(game_hash)
    json = JSON.generate(game_hash)
    save_file(json)
  end

  def self.save_file(json)
    File.open('./output/saved_game.txt', 'w') { |save_game| save_game.puts json }
  end

  def self.to_hash(game_object)
    game_hash = {}
    game_object.instance_variables.each do |var|
      game_hash[var.to_s.delete('@')] = game_object.instance_variable_get(var)
    end
    File.to_json(game_hash)
  end

  def self.to_object
    file_contents = File.read('./output/saved_game.txt').to_s
    data = JSON.parse(file_contents)
    Game.new(data['round'], data['word'], data['guess'], data['guessed'], data['incorrect_guess'])
  end
end
