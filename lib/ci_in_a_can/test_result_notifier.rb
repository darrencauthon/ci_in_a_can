module CiInACan
  module TestResultNotifier
    def self.send_for build, test_result
      CiInACan::Github.client.create_status(build.repo, build.sha, test_result.passed ? "success" : "failure")
    end
  end
end
