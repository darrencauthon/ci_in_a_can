module CiInACan

  module TestRunner

    def self.run_tests_for build
      bash_result = run get_commands_for(build)
      build_test_result_from bash_result
    end

    private

    def self.build_test_result_from bash_result
      CiInACan::TestResult.create( { passed: bash_result.successful,
                                     output: bash_result.output } )
    end

    def self.run commands
      CiInACan::Bash.run commands.join('; ')
    end

    def self.get_commands_for build
      ["cd #{build.local_location}", build.commands].flatten
    end

  end

end
