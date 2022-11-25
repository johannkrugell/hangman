# frozen_string_literal: true

require './lib/input'
require 'pry'

# module validates user responses
module Validate
  include Input

  def validate_input(valid_responses)
    puts 'Please make valid selection' until valid_responses.any?(user_input)
    @response
  end
end
