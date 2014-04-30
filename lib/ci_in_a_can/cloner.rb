module CiInACan

  module Cloner

    def self.clone_a_local_copy_for build
      execute the_commands_to_clone_the(build)
    end

    def self.execute command
      CiInACan::Bash.run command
    end

    def self.the_commands_to_clone_the build
      ["git clone #{build.git_ssh} #{build.local_location}",
       "cd #{build.local_location}",
       "git checkout #{build.sha}"].join('; ')
    end

  end

end
