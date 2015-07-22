require 'bog/initializer'

module Bog
  class Command
    class Init
      def self.execute(profile, options)
        create_skel
        # FIXME: make use of profile.path instead; get passed a Profile object
        profile_path = File.join(File.expand_path('~/.bog'), 'profiles', profile.to_s)
        Dir.mkdir(profile_path) unless File.directory?(profile_path)

        Bog::Initializer::AWS.new(Bog::Profile.find(profile), options) if options.aws?

      end

      private

      def self.create_skel
        bog_root = File.expand_path('~/.bog')
        profiles = File.join(bog_root, 'profiles')
        Dir.mkdir(bog_root) unless File.exists?(bog_root)
        Dir.mkdir(profiles) unless File.exists?(profiles)
      end
    end
  end
end
