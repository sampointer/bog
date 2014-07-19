module Bog
  class Command
    class Init
      def self.execute(profile, options)
        create_skel
        profile_path = File.join(File.expand_path('~/.bog'), 'profiles', profile.to_s)
        Dir.mkdir(profile_path) unless File.directory?(profile_path)

        options.each do |option|
          case option
          when :aws
            Bog::Initializer::AWS.new(Bog::Profile.find(profile), options)
          when :chef
            Bog::Initializer::Chef.new(Bog::Profile.find(profile), options)
          end
        end
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
