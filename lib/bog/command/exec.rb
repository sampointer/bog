module Bog
  class Command
    class Exec 
      def self.execute(profile, options)
	old_profile = get_current_profile
 	Bog::Profile.switch_to(profile.profile_name)
	system(options[:commands])
	Bog::Profile.switch_to(old_profile.profile_name)
      end

      private
      
      def self.get_current_profile
        Bog::Profile.find(File.basename(File.readlink(File.expand_path('~/.bog/current'))))
      end

    end
  end
end
