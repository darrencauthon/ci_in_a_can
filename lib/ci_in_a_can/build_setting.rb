module CiInACan

  module BuildSetting

    def self.commands_for build
      CiInACan::Persistence.find('repos', build.repo)[:commands]
    rescue
      []
    end

  end

end
