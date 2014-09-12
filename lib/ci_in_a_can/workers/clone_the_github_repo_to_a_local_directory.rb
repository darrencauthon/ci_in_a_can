module CiInACan
  class CloneTheGithubRepoToALocalDirectory < Seam::Worker
    def process
      BashRunner.execute 'git clone x'
    end
  end
end
