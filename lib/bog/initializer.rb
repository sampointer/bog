require 'bog/initializer/aws'

module Bog
  class Initializer
    private

    def get_input(text)
      puts text
      return $stdin.gets.chomp
    end
  end
end
