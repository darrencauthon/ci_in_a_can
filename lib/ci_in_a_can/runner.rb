module CiInACan

  module Runner

    def self.run build
      CiInACan::Cloner.clone_a_local_copy_for build
      test_results = CiInACan::TestRunner.run_tests_for build
      CiInACan::TestResultNotifier.send_for build, test_results
    end

  end

end
