module CiInACan
  class CloneTheGithubRepoToALocalDirectory < Seam::Worker
    def process
      BashRunner.execute "git clone #{effort.data['clone_url']}"
    end
  end
end
