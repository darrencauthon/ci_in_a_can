module CiInACan

  class Build

    params_constructor do
      @created_at = Time.now unless @created_at
    end

    attr_accessor :id, :git_ssh, :sha,
                  :local_location, :repo, :branch,
                  :created_at

    def self.parse content
      GithubBuildParser.new.parse content
    end

    def self.create_for file, working_location
      build = CiInACan::Build.parse File.read(file)
      build.id = UUID.new.generate
      build.local_location = "#{working_location}/#{build.id}"
      build
    end

    def commands
      commands = CiInACan::Repo.find(repo).build_commands
      commands.count > 0 ? commands : ['bundle install', 'bundle exec rake']
    end

  end

end
