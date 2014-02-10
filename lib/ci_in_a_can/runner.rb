module CiInACan

  module Runner

    def self.run build
      CiInACan::Github.report_pending_status_for build
      CiInACan::Cloner.clone_a_local_copy_for build
      test_results = CiInACan::TestRunner.run_tests_for build
      CiInACan::TestResultNotifier.send_for build, test_results
    end

  end

end
