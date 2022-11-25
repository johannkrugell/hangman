# frozen_string_literal: true

# Helper module to capture user input
module Input
  def user_input
    @response = gets.chomp.downcase
  end
end
