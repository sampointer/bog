require 'bog/profile'

module Bog
  class Command
    class Default
      def self.execute(profile,options={})
        Bog::Profile.find(profile).make_default
      end

    end
  end
end
