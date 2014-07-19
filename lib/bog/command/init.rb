module Bog
  class Command
    class Init
      def self.execute(profile, options)
        create_skel
        File.mkdir(profile.to_s) unless File.directory?(profile.to_s)
      end

      private

      def self.create_skel
        bog_root = File.expand_path('~/.bog')
        profiles = File.join(bog_root, 'profiles')
        File.mkdir(bog_root) unless File.exists?(bog_root)
        File.mkdir(profiles) unless File.exists?(profiles)
      end
    end
  end
end
