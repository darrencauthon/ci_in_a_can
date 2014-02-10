module CiInACan
  module TestRunner
    def self.run_tests_for build
      commands = ["cd #{build.local_location}"]
      build.commands.each { |c| commands << c }

      bash_result = CiInACan::Bash.run commands.join('; ')

      CiInACan::TestResult.create( { passed: bash_result.successful,
                                     output: bash_result.output      } )
    end
  end
end
