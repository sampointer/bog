require 'bog/profile/exception'
require 'pathname'

module Bog
  class Profile
    attr_accessor :configurations
    attr_reader :configurations, :profile_name, :path

    UNWANTED_ENTRIES = %w( . .. )

    def initialize(options)
      @configurations = options[:configurations]
      @profile_name = options[:profile_name]
      @path = options[:path]
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
      configurations = Dir.entries(profile_root(profile)).delete_if {|e| Bog::Profile::UNWANTED_ENTRIES.include?(e)}
      return Bog::Profile.new({:configurations => configurations, :profile_name => profile, :path => profile_root(profile)})
    end

    def make_current
      current_status_file = File.expand_path('~/.bog/current')
      symlink(profile_root, current_status_file,)
    end

    def make_default(profile)
      File.open('~/.bog/default').write(profile.profile_name)
    end

    def self.current
      Bog::Profile.find(File.basename(File.readlink(File.expand_path('~/.bog/current'))))
    end

    private

    def profile_root
      return Pathname.new(File.expand_path("~/.bog/profiles/#{@profile_name.to_s}"))
    end
 
    def self.profile_root(profile)
      return Pathname.new(File.expand_path("~/.bog/profiles/#{profile.to_s}"))
    end

    def symlink(target, linkfile)
      File.unlink(linkfile) if File.exists?(linkfile)
      File.symlink(target, linkfile)
    end

  end
end
