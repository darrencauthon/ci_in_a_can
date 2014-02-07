module CiInACan
  module TestRunner
    def self.run_tests_for build
      test_result = CiInACan::TestResult.new
      test_result.passed = CiInACan::Bash.run "cd #{build.local_location}; bundle exec rake"
      test_result
    end
  end
end
