require_relative '../spec_helper'

describe CiInACan::TestRunner do

  [:local_location].to_objects {[
    ["1234"],
    ["5678"]
  ]}.each do |test|

    describe "run tests" do

      let(:build) { CiInACan::Build.new }

      let(:bash_result) { CiInACan::BashResult.new }

      before do
        CiInACan::Bash.stubs(:run).returns bash_result
      end

      describe "when no special commands exist" do

        before do
          build.stubs(:local_location).returns test.local_location
        end

        it "should cd into the local directory and run the default rake task" do

          CiInACan::Bash.expects(:run).with("cd #{test.local_location}").returns bash_result

          CiInACan::TestRunner.run_tests_for build
        end

        it "should return a test result" do
          result = CiInACan::TestRunner.run_tests_for build
          result.is_a?(CiInACan::TestResult).must_equal true
        end

        it "should use the create method to create the TestResult" do

          CiInACan::TestResult.expects(:new).never
          CiInACan::TestResult.expects(:create).with { |v| true }.once
          CiInACan::TestRunner.run_tests_for build
        end

        it "should pass the output value from the bash result" do
          output = Object.new
          bash_result.stubs(:output).returns output
          result = CiInACan::TestRunner.run_tests_for build
          result.output.must_be_same_as output
        end

        it "should return a passed test result if the command returns true" do
          bash_result.stubs(:successful).returns true
          result = CiInACan::TestRunner.run_tests_for build
          result.passed.must_equal true
        end

        it "should return a failed test result if the command returns true" do
          bash_result.stubs(:successful).returns false
          result = CiInACan::TestRunner.run_tests_for build
          result.passed.must_equal false
        end

      end

      describe "when two special commands exist" do

        before do
          build.stubs(:local_location).returns test.local_location
        end

        it "should cd into the local directory, run the commands, then run the default rake task" do
          build.commands = ["1", "2"]

          CiInACan::Bash.expects(:run).with("cd #{test.local_location}; 1; 2").returns bash_result

          CiInACan::TestRunner.run_tests_for build
        end

      end

    end

  end

end
