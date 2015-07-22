require 'bog/profile'

module Bog
  class Command
    class Default
      def self.execute(profile,options={})
        old_profile = Bog::Profile.current
        Bog::Profile.switch_to(profile.profile_name)
        Bog::Profile.current.make_default
        Bog::Profile.switch_to(old_profile.profile_name)
      end

    end
  end
end
