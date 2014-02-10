module CiInACan

  class Build
    params_constructor

    attr_accessor :id, :git_ssh, :sha,
                  :local_location, :repo

    def self.parse content
      GithubBuildParser.new.parse content
    end

    def commands
      ['bundle install', 'bundle exec rake']
    end

  end

end
