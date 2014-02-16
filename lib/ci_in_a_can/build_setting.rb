module CiInACan

  module BuildSetting

    def self.commands_for build
      CiInACan::Persistence.find('build_commands', build.repo)[:commands]
    rescue
      []
    end

  end

end
