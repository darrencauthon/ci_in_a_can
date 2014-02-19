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

    def commands
      #commands = CiInACan::BuildSetting.commands_for self
      commands = CiInACan::Repo.find(repo).build_commands
      commands.count > 0 ? commands : ['bundle install', 'bundle exec rake']
    end

  end

end
