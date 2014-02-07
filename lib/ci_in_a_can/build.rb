module CiInACan

  class Build

    attr_accessor :git_ssh, :local_location, :repo

    def self.parse content
      data = JSON.parse content
      data['payload'] = JSON.parse data['payload']

      splat = data['payload']['compare'].split('/')

      build = self.new
      build.git_ssh = "git@github.com:#{splat[3]}/#{splat[4]}.git"
      build.repo    = "#{splat[3]}/#{splat[4]}"
      build
    end

  end

end
