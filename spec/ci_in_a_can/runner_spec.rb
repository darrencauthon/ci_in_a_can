require_relative '../spec_helper'

describe CiInACan::Runner do

  describe "run" do

    let(:build)  { CiInACan::Build.new }

    before do
      CiInACan::Github.stubs(:report_pending_status_for)
      CiInACan::Cloner.stubs(:clone_a_local_copy_for)
      CiInACan::TestRunner.stubs(:run_tests_for)
      CiInACan::TestResultNotifier.stubs(:send_for)
      CiInACan::Cleaner.stubs(:remove_local_copy_of)
    end

    it "should clone the git repo" do
      CiInACan::Cloner.expects(:clone_a_local_copy_for).with build
      CiInACan::Runner.run build
    end

    it "should run the tests" do
      CiInACan::TestRunner.expects(:run_tests_for).with build
      CiInACan::Runner.run build
    end
    
    it "should cleanup after itself" do
      CiInACan::Cleaner.expects(:remove_local_copy_of).with build
      CiInACan::Runner.run build
    end

    it "should run the test after the clone" do
      count = 0
      CiInACan::Cloner.stubs(:clone_a_local_copy_for).with { count += 1 }
      CiInACan::TestRunner.stubs(:run_tests_for).with { count.must_equal 1; true }

      CiInACan::Runner.run build
    end

    it "should cleanup after the test results are retrieved" do
      count = 0
      CiInACan::TestRunner.stubs(:run_tests_for).with { count += 1 }
      CiInACan::Cleaner.stubs(:remove_local_copy_of).with { count.must_equal 1; true }

      CiInACan::Runner.run build
    end

    it "should call the test result notifier with the build and the results" do
      test_results = Object.new
      CiInACan::TestRunner.stubs(:run_tests_for).with(build).returns test_results

      CiInACan::TestResultNotifier.expects(:send_for).with build, test_results

      CiInACan::Runner.run build
    end

    it "should send a pending notification to github" do

      build.repo = Object.new
      build.sha  = Object.new
      CiInACan::Github.expects(:report_pending_status_for).with build

      CiInACan::Runner.run build
    end

  end

end
