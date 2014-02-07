module CiInACan

  class Build

    attr_accessor :git_ssh

    def self.parse content
      data = JSON.parse content

      splat = data['payload']['compare'].split('/')

      build = self.new
      build.git_ssh = "git@github.com:#{splat[3]}/#{splat[4]}.git"
      build
    end

  end

end
