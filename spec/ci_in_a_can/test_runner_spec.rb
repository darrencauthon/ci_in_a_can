require_relative '../spec_helper'

describe CiInACan::TestRunner do

  [:local_location].to_objects {[
    ["1234"],
    ["5678"]
  ]}.each do |test|

    describe "run tests" do

      let(:build) { CiInACan::Build.new }

      before do
        CiInACan::Bash.stubs(:run)
      end

      it "should cd into the local directory and run the default rake task" do
        build.local_location = test.local_location

        CiInACan::Bash.expects(:run).with("cd #{test.local_location}; bundle exec rake")

        CiInACan::TestRunner.run_tests_for build
      end

      it "should return a test result" do
        result = CiInACan::TestRunner.run_tests_for build
        result.is_a?(CiInACan::TestResult).must_equal true
      end

      it "should return a passed test result if the command returns true" do
        CiInACan::Bash.stubs(:run).returns true
        result = CiInACan::TestRunner.run_tests_for build
        result.passed.must_equal true
      end

      it "should return a failed test result if the command returns true" do
        CiInACan::Bash.stubs(:run).returns false
        result = CiInACan::TestRunner.run_tests_for build
        result.passed.must_equal false
      end

    end

  end

end
