module CiInACan
  module TestRunner
    def self.run_tests_for build
      commands = ["cd #{build.local_location}", "bundle install"]
      build.pre_test_commands.each { |c| commands << c }
      commands << "bundle exec rake"

      bash_result = CiInACan::Bash.run commands.join('; ')

      CiInACan::TestResult.new( { passed: bash_result.successful,
                                  output: bash_result.output      } )
    end
  end
end
