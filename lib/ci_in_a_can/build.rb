module CiInACan

  class Build
    params_constructor

    attr_accessor :git_ssh, :local_location, :repo, :sha
    attr_accessor :id

    def self.parse content
      GithubBuildParser.new.parse content
    end

    def commands
      ['bundle install', 'bundle exec rake']
    end

  end

end
