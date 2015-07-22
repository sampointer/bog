require 'bog/profile'

module Bog
  class Command
    class Show
      def self.execute
        puts Bog::Profile.current.profile_name
      end

    end
  end
end
