# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'pry'

# Object that loads the dictionary of words
class Dictionary
  def dictionary
    uri = URI('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt')
    content = Net::HTTP.get(uri) # => String
    content.split("\n")
  end
end
