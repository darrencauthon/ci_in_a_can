module CiInACan

  module BuildSetting

    def self.commands_for repo
      return [] if repo.to_s == ''
      CiInACan::Repo.find(repo).build_commands
    end

  end

end
