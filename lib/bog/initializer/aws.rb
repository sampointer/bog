module Bog
  class Initializer
    class AWS
      def initialize(profile, options)
        @access_key_id = get_input('Enter your AWS access key id:')
        @secret_access_key = get_input('Enter your AWS secret access key:')
        @region = get_input('Enter your default region (e.g. us-east-1):')
      
        file = File.open(File.join(profile.path, '.aws', 'config'), 'w')
        file.write('[default]')
        file.write("aws_access_key_id=#{@access_key_id}")
        file.write("aws_secret_access_key=#{@secret_access_key}")
        file.write("region=#{@region}")
        file.close
      end
    end
  end
end
