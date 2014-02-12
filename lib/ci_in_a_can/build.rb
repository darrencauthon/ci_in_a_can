module CiInACan

  class Build

    params_constructor { @created_at = Time.now }

    attr_accessor :id, :git_ssh, :sha,
                  :local_location, :repo,
                  :created_at

    def self.parse content
      GithubBuildParser.new.parse content
    end

    def commands
      ['bundle install', 'bundle exec rake']
    end

  end

end
