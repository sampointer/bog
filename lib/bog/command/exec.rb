module Bog
  class Command
    class Exec 
      def self.execute(profile, options)
        old_profile = Bog::Profile.get_current_profile
        Bog::Profile.switch_to(profile.profile_name)
        system("#{options[:commands]} 2>&1")
        Bog::Profile.switch_to(old_profile.profile_name)
      end

    end
  end
end
