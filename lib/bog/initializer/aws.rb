module Bog
  class Initializer
    class AWS < Initializer
      def initialize(profile, options)
        @access_key_id = get_input('Enter your AWS access key id:')
        @secret_access_key = get_input('Enter your AWS secret access key:')
        @region = get_input('Enter your default region (e.g. us-east-1):')

        plugin_directory = File.join(profile.path, '.aws')

        Dir.mkdir(plugin_directory) unless File.directory?(plugin_directory)
      
        file = File.open(File.join(plugin_directory, 'config'), 'w')
        file.write("[default]\n")
        file.write("aws_access_key_id=#{@access_key_id}\n")
        file.write("aws_secret_access_key=#{@secret_access_key}\n")
        file.write("region=#{@region}\n")
        file.close
      end
    end
  end
end
