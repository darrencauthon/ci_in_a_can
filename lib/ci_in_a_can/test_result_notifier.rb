module CiInACan
  module TestResultNotifier
    def self.send_for build, test_result
      CiInACan::Github.report_complete_status_for build, test_result
    end
  end
end
