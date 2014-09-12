module CiInACan
  class CloneTheGithubRepoToALocalDirectory < Seam::Worker
    def process
      BashRunner.execute "git clone #{effort.data['git_ssh']}"
    end
  end
end
