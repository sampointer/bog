module Bog
  class Command
    class Exec 
      def self.execute(profile, options)
        old_profile = Bog::Profile.current
        Bog::Profile.switch_to(profile.profile_name)
        system("#{options[:commands]} 2>&1")
        Bog::Profile.switch_to(old_profile.profile_name)
      end

    end
  end
end
