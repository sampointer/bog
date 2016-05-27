require 'bog/profile'

module Bog
  class Command
    class List
      def self.execute
        profiles = Dir.glob(
          File.expand_path(ENV['HOME'] + "/.bog/profiles/*/") )
        profiles.collect! { |p| p.split('/').last }
        profiles.select { |p|
          p == Bog::Profile.current.profile_name }[0] << "*"
        puts profiles.sort
      end
    end
  end
end
