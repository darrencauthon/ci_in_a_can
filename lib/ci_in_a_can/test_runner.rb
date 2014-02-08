module CiInACan
  module TestRunner
    def self.run_tests_for build
      test_result = CiInACan::TestResult.new
      commands = ["cd #{build.local_location}", "bundle install"]
      build.pre_test_commands.each { |c| commands << c }
      commands << "bundle exec rake"
      test_result.passed = CiInACan::Bash.run commands.join('; ')
      test_result
    end
  end
end
