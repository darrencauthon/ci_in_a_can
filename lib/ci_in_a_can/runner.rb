module CiInACan

  module Runner

    def self.run build
      report_pending_status_for build
      clone_a_local_copy_of build
      test_results = run_the_tests_for build
      CiInACan::Cleaner.remove_local_copy_of build
      send_notifications_for build, test_results
    end

    private

    def self.send_notifications_for build, test_results
      CiInACan::TestResultNotifier.send_for build, test_results
    end

    def self.run_the_tests_for build
      CiInACan::TestRunner.run_tests_for build
    end

    def self.report_pending_status_for build
      CiInACan::Github.report_pending_status_for build
    end

    def self.clone_a_local_copy_of build
      CiInACan::Cloner.clone_a_local_copy_for build
    end

  end

end
