module CiInACan

  module TestResultNotifier

    def self.send_for build, test_result
      report_results_to_github build, test_result
    end

    private

    def self.report_results_to_github build, test_result
      CiInACan::Run.add build, test_result
      CiInACan::Github.report_complete_status_for build, test_result
    end

  end

end
