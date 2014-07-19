require 'bog/profile/exception'
require 'pathname'

module Bog
  class Profile
    attr_accessor :configurations
    attr_reader :name

    def initialize(options)
      @configurations = options[:configurations]
      @name = options[:name]
    end

    def self.switch_to(profile)
      target_profile = self.find(profile)
      target_profile.make_current
    end

    def self.find(profile)
      if Dir.entries(File.expand_path('~/.bog/profiles')).include?(profile.to_s)
        return Bog::Profile.load(profile)
      else
	raise Bog::Profile::Exception::ProfileNotFound
      end
    end

    def self.load(profile)
      configurations = Dir.entries(profile_root)
      return Bog::Profile.new { :configurations => configurations, :name => profile }
    end

    def make_current(profile)
      current_status_file = File.expand_path('~/.bog/current')
      symlink(current_status_file, profile_root)
    end

    private
 
    def profile_root
      return Pathname.new.(File.expand_path("~/.bog/profiles/#{profile.to_s}"))
    end

    def symlink(linkfile, target)
      File.symlink(linkfile, target)
    end

  end
end
